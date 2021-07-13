Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC463C6DCF
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhGMJ4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhGMJ4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:56:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45012C0613DD;
        Tue, 13 Jul 2021 02:53:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so1077462pjb.3;
        Tue, 13 Jul 2021 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KkZcrEoPr0L+sZw8CYQ50ojjAUyJqDTEoENZmh4DIg=;
        b=uHOlNVDShBkw3P8wOyrlZxXfEnfjPp6OXAQJBW5PneBP3b46LnHkrXmcCh43UoRO4b
         KZ6+DXui0vdLLx38tBK5Ifb/PjvAAvT7DpU5wjmK/1nPcdN6w+AMChfpRyxXIyo3IEe5
         ops8pUQMBMdtTH7uG4C9bJTbIXL0OVhucx0FLWOzQNjlF6NurvjXbZty1wcnvGJ7wYzj
         2L7D9SbAxpJvXWW+ejvBMnhuimBQ7yDCRVdkSJJDqooiR3E1/DRVEE4vQeSBfW81YuL7
         xby/DF4EFdCRNMrAlnxSB3aC7A8LIniDfMECWMUaGWn5DJgNWv00rstZrTh7clUBf/lp
         OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KkZcrEoPr0L+sZw8CYQ50ojjAUyJqDTEoENZmh4DIg=;
        b=oqbNoIIZE5d4c8G5Ns6OcUWHv4PSL98I+/M6E7PvdEb0rWuySGOGLCrC8JiCvETmL6
         Rrm95n18u34xqCmq2EOwON2WYN0HsSRtoKZyTcb65wUkKNXGlpj2lSCAFjPQNEmW9a8+
         37KqOQNi3hRoG1n/sMIKAafovCgMfzXXp0wksFx9Qc/B3vyxvOyaYf16qQxroebWD4Oa
         L8alU3pVQeDW3T+jw3zgl3ZNHtcCdcpmdp0gGcXGJy56b40DTWXtrsefSoSDv5MRr7X9
         veSGews1IYdq+pscR0dn623rxrqlTsYMsdbqXUG8r88gsOQm0amEqTI5g6MPjTloijqu
         yIZQ==
X-Gm-Message-State: AOAM530nmSM+KdgSA9XOQ2gOKnvGBidLoR4MyfT8xHsryBrxzSm7A0wF
        bkJAvc5+u4FELv19h4PCmyI=
X-Google-Smtp-Source: ABdhPJzMQHqMn6v58dPxgVbR4ySW5P5oNiSk9rOakvkG259Iof56B64c7QtIdlaz8zXY9BRzmWNZZg==
X-Received: by 2002:a17:902:bc44:b029:12b:415:57bf with SMTP id t4-20020a170902bc44b029012b041557bfmr2846559plz.33.1626170030849;
        Tue, 13 Jul 2021 02:53:50 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:53:50 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v13 02/17] counter: Return error code on invalid modes
Date:   Tue, 13 Jul 2021 18:53:06 +0900
Message-Id: <7f9d1c50aac1254f6e91f529ceee10adebd86406.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Only a select set of modes (function, action, etc.) are valid for a
given device configuration. This patch ensures that invalid modes result
in a return -EINVAL. Such a situation should never occur in reality, but
it's good to define a default switch case for the sake of making the
intent of the code clear.

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Acked-by: David Lechner <david@lechnology.com>
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c            | 20 ++++++++++++------
 drivers/counter/microchip-tcb-capture.c |  6 ++++++
 drivers/counter/stm32-lptimer-cnt.c     | 10 +++++----
 drivers/counter/ti-eqep.c               | 27 +++++++++++++++----------
 4 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 81f9642777fb..b358b2b2b883 100644
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
 
@@ -349,7 +353,7 @@ static int quad8_action_get(struct counter_device *counter,
 	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
 		if (synapse->signal->id == signal_a_id)
 			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
-		break;
+		return 0;
 	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
 		if (synapse->signal->id == signal_a_id) {
 			quad8_direction_get(counter, count, &direction);
@@ -359,17 +363,18 @@ static int quad8_action_get(struct counter_device *counter,
 			else
 				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
 		}
-		break;
+		return 0;
 	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
 		if (synapse->signal->id == signal_a_id)
 			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
-		break;
+		return 0;
 	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
 		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
-		break;
+		return 0;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static const struct counter_ops quad8_ops = {
@@ -529,6 +534,9 @@ static int quad8_count_mode_set(struct counter_device *counter,
 	case COUNTER_COUNT_MODE_MODULO_N:
 		cnt_mode = 3;
 		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
 
 	mutex_lock(&priv->lock);
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 51b8af80f98b..0c9a61962911 100644
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
index c19d998df5ba..78f383b77bd2 100644
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
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 65df9ef5b5bc..c303eb17c111 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -157,7 +157,7 @@ static int ti_eqep_action_get(struct counter_device *counter,
 		 * QEPA and QEPB trigger QCLK.
 		 */
 		*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
-		break;
+		return 0;
 	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
 		/* In direction-count mode only rising edge of QEPA is counted
 		 * and QEPB gives direction.
@@ -165,12 +165,14 @@ static int ti_eqep_action_get(struct counter_device *counter,
 		switch (synapse->signal->id) {
 		case TI_EQEP_SIGNAL_QEPA:
 			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
-			break;
-		default:
+			return 0;
+		case TI_EQEP_SIGNAL_QEPB:
 			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
-			break;
+			return 0;
+		default:
+			/* should never reach this path */
+			return -EINVAL;
 		}
-		break;
 	case TI_EQEP_COUNT_FUNC_UP_COUNT:
 	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
 		/* In up/down-count modes only QEPA is counted and QEPB is not
@@ -186,15 +188,18 @@ static int ti_eqep_action_get(struct counter_device *counter,
 				*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
 			else
 				*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
-			break;
-		default:
+			return 0;
+		case TI_EQEP_SIGNAL_QEPB:
 			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
-			break;
+			return 0;
+		default:
+			/* should never reach this path */
+			return -EINVAL;
 		}
-		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static const struct counter_ops ti_eqep_counter_ops = {
-- 
2.32.0

