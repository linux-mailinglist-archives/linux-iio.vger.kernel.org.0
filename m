Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB343A0942
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhFIBfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhFIBfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B284C061789;
        Tue,  8 Jun 2021 18:33:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u126so13161034pfu.13;
        Tue, 08 Jun 2021 18:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpaFCbrFJuasI9AlHX5tdEfpbbvJOTfDx2HbC+EDf2A=;
        b=MLDZubyhwJ5ggutZAZCWhOKMgnwHYGDQb2EFGe1VyucR4ZqfDSmstbef1c399iIjYz
         S2HjKqckmE0W+y27o3EFkb1p0SPXPPILyLEV1XexRvJoGY8AFHxiCljfN/YZ//g3Oa7m
         0x/NojQHjZRW7BFsOUMma6tRVml8KgiULhDxW5SjBjeC1CuEbWK7BHv5b9f3qK1b5uYw
         A/tCl3+x1TyqI9qjL1u8+t82QW2I5W0596n/Fic689+YSDRKYRZRCcqExvdqP1QyDcop
         Qc3RIx+4T5pRIvXNwwb7y6RLXqcK3gwaXItwhHceZgNtXyVvK+Sv9oqac3q/VTY0wSc3
         AGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpaFCbrFJuasI9AlHX5tdEfpbbvJOTfDx2HbC+EDf2A=;
        b=CbUf7lxyKbTokpuUyhNoFSJfdXpKE7rP1GMXsoJZTQa8Wudbc89cG9hWnZsNEPkgCp
         9ttCDj8OigEBU4Js2eOMtdYcl1rZl11oZQ+hcgE93GLPAMJMIo8EWQk+NKnmGKhuvGhk
         c3DyKDMvTBXTmR1OZL7Tf7aYc6DbED//lh43A1NGdGYjRqRyf63vPQYlHtL19jMbiveO
         OP1yIv3CrwLPw34I4kwhBfwIkir1dfy6gxWDOhKnE7U1yCaZECtFM2KnyNmgJEPGO/Xu
         HJPoAEV/pe5tJzTTgdtDTcYs6p1vBbAFPjbebgEsEcO6nP4R7aHtP2mM/VtF1BsBGyay
         iuWA==
X-Gm-Message-State: AOAM533nIHEs18ddZooOSnF+p7PCG96sv2uJ5BfmfCWW7ov983g3VOC/
        07gixU93ZSMOKQ9rCl5yfW4=
X-Google-Smtp-Source: ABdhPJzsOPJM/6kuqrFECT0lLD2DePx4TR5F1IJfH7lQbvKeVNqM/oRoFJB6YrCVYS/7pDcnignSjw==
X-Received: by 2002:a63:1114:: with SMTP id g20mr1154622pgl.385.1623202402154;
        Tue, 08 Jun 2021 18:33:22 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:21 -0700 (PDT)
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
Subject: [PATCH v11 18/33] counter: Return error code on invalid modes
Date:   Wed,  9 Jun 2021 10:31:21 +0900
Message-Id: <6f74bf8b237340ef079b7d3e3553f47434f47f67.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: David Lechner <david@lechnology.com>
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
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
2.32.0

