Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A061319E20
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBLMPk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBLMPd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9717DC061756;
        Fri, 12 Feb 2021 04:14:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c1so6509669qtc.1;
        Fri, 12 Feb 2021 04:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ckwJFnHA3Ef54UBvumcIhohktCn1MgimffdexzCqvp8=;
        b=rID13hQE22qt9kcq+wLvY7Fe0EkTknHvuhduTdt/5CijZn42zVE6W2yBGpK5X/36w+
         m17P0l7fxXZ3a189boYzBOGrvZsP9+/6W0Fc8KhvFqq2lpXCIjVD+u8sp2In6bOkOFuQ
         tDxesjYyKRpOclTKC4CWsFILYh1w6krnHWyDeDVMzG7LWke+CQUd2+0oZCxJjwYd7hgt
         apQt8lTpx8babc/c5f8XadWmQh+zcVwWexRzLedYpyn6rNJRVzO+NJw55QLynIg8bAWk
         Alkplvh+kP+5ClxDSAtQ/RHGp5BrBAew8TifCB1k5DHbJGE1FucPVtYZwckOF0oTm9E1
         Mo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckwJFnHA3Ef54UBvumcIhohktCn1MgimffdexzCqvp8=;
        b=KITG2FWsoQje5NzuWMdBeJBWCsuBJ4+GUAJlq4BiEhE5qIpKDww52Kajh6dbsw3oMe
         y0EMeYcdlhZQspXISdyDFp1hrUI/V9jw2nq83zppA7GJPyUVvCXNxgSaSg+8lbgxdHy0
         21T2hX1NdM8nsvTtxfsJjnA2wQ1gpA2hQBxSvBYyrOtAitXll8hUBT254L16qFqLKmYw
         gTRWZDydkxMa570J0jgwyDSHESNlyhQyfC/fNg6mhTlKOG9RTHI4mWB7GuZhF4pufY4s
         ngkq8b0k6huMGwyXCTpk8dIKNiwEAKLG8VzIH3P7QiHw/B1GQVM9WCvdLYkKJhJEXxoz
         JdPw==
X-Gm-Message-State: AOAM533UQSvYlpgYWvBHdOIyq80e2sZppMBpQCtfZ8nMAlhLv9N4FLdq
        ciBGOJOAFwQtx3uQrhoDxds=
X-Google-Smtp-Source: ABdhPJzPXPFhdl3w1dHI2M/nPQxpkVoxksZtolDQFvMNNntM0Z1oUbvll2KQyXp6re8HSM36Xkdm0A==
X-Received: by 2002:aed:2e42:: with SMTP id j60mr2050905qtd.189.1613132091879;
        Fri, 12 Feb 2021 04:14:51 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:51 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 09/22] counter: Return error code on invalid modes
Date:   Fri, 12 Feb 2021 21:13:33 +0900
Message-Id: <58e7c59bb7c7bb94c8655903308842d9d9e9907a.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Only a select set of modes (function, action, etc.) are valid for a
given device configuration. This patch ensures that invalid modes result
in a return -EINVAL. Such a situation should never occur in reality, but
it's good to define a default switch cases for the sake of making the
intent of the code clear.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c            | 10 ++++++++++
 drivers/counter/microchip-tcb-capture.c |  6 ++++++
 drivers/counter/stm32-lptimer-cnt.c     | 10 ++++++----
 drivers/counter/stm32-timer-cnt.c       |  3 +++
 drivers/counter/ti-eqep.c               |  3 +++
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9a96296b0625..674263b4d2c4 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -273,6 +273,10 @@ static int quad8_function_set(struct counter_device *counter,
 			*scale = 2;
 			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
 			break;
+		default:
+			/* should never reach this path */
+			mutex_unlock(&priv->lock);
+			return -EINVAL;
 		}
 	}
 
@@ -367,6 +371,9 @@ static int quad8_action_get(struct counter_device *counter,
 	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
 		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
 
 	return 0;
@@ -529,6 +536,9 @@ static int quad8_count_mode_set(struct counter_device *counter,
 	case COUNTER_COUNT_MODE_MODULO_N:
 		cnt_mode = 3;
 		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
 
 	mutex_lock(&priv->lock);
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 710acc0a3704..ee979b011012 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -133,6 +133,9 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
 		bmr |= ATMEL_TC_QDEN | ATMEL_TC_POSEN;
 		cmr |= ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_ABETRG | ATMEL_TC_XC0;
 		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
 
 	regmap_write(priv->regmap, ATMEL_TC_BMR, bmr);
@@ -226,6 +229,9 @@ static int mchp_tc_count_action_set(struct counter_device *counter,
 	case MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE:
 		edge = ATMEL_TC_ETRGEDG_BOTH;
 		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
 
 	return regmap_write_bits(priv->regmap,
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 937439635d53..daf988e7b208 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -206,9 +206,10 @@ static int stm32_lptim_cnt_function_set(struct counter_device *counter,
 		priv->quadrature_mode = 1;
 		priv->polarity = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
 		return 0;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
@@ -326,9 +327,10 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
 	case STM32_LPTIM_ENCODER_BOTH_EDGE:
 		*action = priv->polarity;
 		return 0;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static int stm32_lptim_cnt_action_set(struct counter_device *counter,
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index ef2a974a2f10..431a3d08ed6c 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -296,6 +296,9 @@ static int stm32_action_get(struct counter_device *counter,
 		/* counts up/down on both TI1FP1 and TI2FP2 edges */
 		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index a60aee1a1a29..7844fdf78a97 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -192,6 +192,9 @@ static int ti_eqep_action_get(struct counter_device *counter,
 			break;
 		}
 		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.30.0

