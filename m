Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E543326C6
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhCINWB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhCINVp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D9C06174A;
        Tue,  9 Mar 2021 05:21:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y67so9521108pfb.2;
        Tue, 09 Mar 2021 05:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsY4hvP6vR3kebyGKLSUcX7e2GsC73FIe/tGpJlrL+E=;
        b=CzxAejpt6T1ihScgSygWzUdshIWTP9koo4T/FK5ybdV479ghQpXwvuCiqw1TIfz+Fc
         lvH9fCSBWbsok86OzjGGdWr4VeYTzBm6j2Mf9d4G6HXuwJeZ0ELLBsjpGsOMgxwLHu6H
         ydsxnpQm6YZ+e+8JA/eKY/yNbNn3H7C/1ZexWqAy5ltP73z/JDh9Ei0jc3cPB+ki/Hg5
         xSRzuNllWyDnfZLIAmrYgyu9WqAaIuQdJv+mNLjX/PuoTj1pyPuv18FCvks/Xbfzf57t
         veV3bOOSNoQdyZ7Pxqv72trO9m6rhzP19mOUYE+v1V3i3AmZOEetTLd3L9B5dHGFsKTD
         wTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsY4hvP6vR3kebyGKLSUcX7e2GsC73FIe/tGpJlrL+E=;
        b=tze6xKcRRJtcGYQh7lCjGYjxyb4Yd7ob8viDHL/d4fHxOTAb+6BUZUmG80/9PcwDzJ
         UeucJG/PAsWCOmeM6k0mItkgyLqcYJEhH8cQchLW4ON4scI3U3Ncp591QnoAeBbla9Ww
         PqpZ33hFQb229/eMPxgXUTa/Q6ZWidpqs2HxIwUztWfAYa0iYnfpeewxvSAdYMrdpBVY
         wGxl614brNNgVNzq6oDNIfVbtNUBaDqhNDl08yMR9zUBhe0pt8DhjCwW3ArEPG1EFWen
         S3afRxr7xrWZ6y9zYK1SXdn2dZk84GNmwwy7wvBEO6i7BUupCgSQobx5cqZNp9ZlYxUq
         cMjg==
X-Gm-Message-State: AOAM531ibQ4auzfteLa0YTzDb23qT7/EL80+mzaeUYKY269+qmIK+D3q
        Fu+ORak0JTDCg06k/G51wak=
X-Google-Smtp-Source: ABdhPJzgrCqjg7OU4ZSKNWl4RO39vCHDj/yCkNuUh/xDwXYHDq6WZbBuOTPji1vP8BVlrz5NNUfwKQ==
X-Received: by 2002:aa7:8d84:0:b029:1f8:3449:1bc6 with SMTP id i4-20020aa78d840000b02901f834491bc6mr6482584pfr.76.1615296105432;
        Tue, 09 Mar 2021 05:21:45 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:45 -0800 (PST)
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
Subject: [PATCH v9 18/33] counter: Return error code on invalid modes
Date:   Tue,  9 Mar 2021 22:19:31 +0900
Message-Id: <22c9bc0a85509df31483b5dcfa50562ba0b16295.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
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
 drivers/counter/104-quad-8.c            | 20 +++++++----
 drivers/counter/microchip-tcb-capture.c |  6 ++++
 drivers/counter/stm32-lptimer-cnt.c     | 10 +++---
 drivers/counter/ti-eqep.c               | 45 +++++++++++--------------
 4 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 09d779544969..b7d6c1c43655 100644
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
index 65df9ef5b5bc..878725c2f010 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -157,44 +157,39 @@ static int ti_eqep_action_get(struct counter_device *counter,
 		 * QEPA and QEPB trigger QCLK.
 		 */
 		*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
-		break;
+		return 0;
 	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
 		/* In direction-count mode only rising edge of QEPA is counted
 		 * and QEPB gives direction.
 		 */
-		switch (synapse->signal->id) {
-		case TI_EQEP_SIGNAL_QEPA:
-			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
-			break;
-		default:
+		if (synapse->signal->id == TI_EQEP_SIGNAL_QEPB)
 			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
-			break;
-		}
-		break;
+		else
+			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
+		return 0;
 	case TI_EQEP_COUNT_FUNC_UP_COUNT:
 	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
 		/* In up/down-count modes only QEPA is counted and QEPB is not
 		 * used.
 		 */
-		switch (synapse->signal->id) {
-		case TI_EQEP_SIGNAL_QEPA:
-			err = regmap_read(priv->regmap16, QDECCTL, &qdecctl);
-			if (err)
-				return err;
-
-			if (qdecctl & QDECCTL_XCR)
-				*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
-			else
-				*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
-			break;
-		default:
+		if (synapse->signal->id == TI_EQEP_SIGNAL_QEPB) {
 			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
-			break;
+			return 0;
 		}
-		break;
-	}
 
-	return 0;
+		err = regmap_read(priv->regmap16, QDECCTL, &qdecctl);
+		if (err)
+			return err;
+
+		if (qdecctl & QDECCTL_XCR)
+			*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
+		else
+			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
+		return 0;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
+	}
 }
 
 static const struct counter_ops ti_eqep_counter_ops = {
-- 
2.30.1

