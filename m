Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25399224113
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGQQ52 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgGQQ4R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D4C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so11888286wru.6
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3fyiDGFdlbLNYGeR71nnz3VOwvLrObA2piXc/v38Go=;
        b=WmxyBLdPFiTMIB9rmrspNDNftuqma7nAEm/9RcMOSzJjAD6D4inZeyskwPmwX//ID1
         OShWYYXvlSNN4qj0U0acKpFl7lOtvjTsxso+bNYIMiLzRTdfLMGwxcGgpVzjS8IEpKUm
         Xowpf4oECwAHxwFRyVWwGAevH72O9bR1DZ/huytShBk8GwpB947CDWPSNqFeS4MfQPqM
         l/hX8yK68gPPR9uQogO9Xow2x3akFFCq42VLZ0RmTJzyYmFkbBd37ORm+y863MZshCgY
         ZbsAXTLVmyhKDyocDIzGMAUUtGb98XbPdJx3c0uGTY+yRQ2nb+VTKGcX4CQ/AB0ri0xw
         I3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3fyiDGFdlbLNYGeR71nnz3VOwvLrObA2piXc/v38Go=;
        b=e4yujTxvJ3/1kFBzVyYZLgabAJXeB1kgG5EoKSuoxfYz65WjIchNDSIptet5BwmW/y
         k/5x7cZnoeGGlDJKjPAXd2vYVQ4Lc+NWniLNz9E72jG/Nnmx4yM3ySWwHdRItpbCZRMK
         yh/AgQfcrF1ISQJhqJMbenVL/M94Hym1eUBkLM3oIHBosHqwOvQeZTNb9h+BRRohJwp7
         BCcUuVxShA9U50l0bH24QHvB32ZenBea2wk6hA/L8vlO+XxLiQuRoEfEWetPy4i2snCK
         2eaoxYSqZKy+O8xL1PQVhfrCdmYLNcEQ57VHJ2tE/erKed2JXD+qDw/eKEyJyp9NiGU6
         9jRw==
X-Gm-Message-State: AOAM533OOqbb9sPFdtHMeWUEsGrR2eaqElXfbw7uonJ/uZbAgb+jKctO
        bJni+wtq1Qul2unKS2KHXcLszw==
X-Google-Smtp-Source: ABdhPJyxGlgmwpdyXgtW7B3rqiCsiz02bfeSDBMqpGeL+5khgX6H2eUvHJBFwak6Kl9QbaLMkwZ5Sg==
X-Received: by 2002:adf:ef46:: with SMTP id c6mr11237076wrp.34.1595004975766;
        Fri, 17 Jul 2020 09:56:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/30] iio: adc: cpcap-adc: Demote seemingly unintentional kerneldoc header
Date:   Fri, 17 Jul 2020 17:55:23 +0100
Message-Id: <20200717165538.3275050-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

None of the headers demoted here provide any descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'ato_in' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_in' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'adc_ps_factor_in' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_ps_factor_in' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'ato_out' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_out' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'adc_ps_factor_out' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:100: warning: Function parameter or member 'atox_ps_factor_out' not described in 'cpcap_adc_ato'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD0' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTP' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_VBUS' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD3' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BPLUS_AD4' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_CHG_ISENSE' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTI' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_USB_ID' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD8' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_AD9' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_LICELL' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_HV_BATTP' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSX1_AD12' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSX2_AD13' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSY1_AD14' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_TSY2_AD15' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTP_PI16' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_BATTI_PI17' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:153: warning: Enum value 'CPCAP_ADC_CHANNEL_NUM' not described in enum 'cpcap_adc_channel'
 drivers/iio/adc/cpcap-adc.c:165: warning: Enum value 'CPCAP_ADC_TIMING_IMM' not described in enum 'cpcap_adc_timing'
 drivers/iio/adc/cpcap-adc.c:165: warning: Enum value 'CPCAP_ADC_TIMING_IN' not described in enum 'cpcap_adc_timing'
 drivers/iio/adc/cpcap-adc.c:165: warning: Enum value 'CPCAP_ADC_TIMING_OUT' not described in enum 'cpcap_adc_timing'

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/cpcap-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 5086a337f4c9a..be638fcec03f6 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -82,7 +82,7 @@
 
 #define CPCAP_ADC_MAX_RETRIES		5	/* Calibration */
 
-/**
+/*
  * struct cpcap_adc_ato - timing settings for cpcap adc
  *
  * Unfortunately no cpcap documentation available, please document when
@@ -121,7 +121,7 @@ struct cpcap_adc {
 	bool done;
 };
 
-/**
+/*
  * enum cpcap_adc_channel - cpcap adc channels
  */
 enum cpcap_adc_channel {
@@ -152,7 +152,7 @@ enum cpcap_adc_channel {
 	CPCAP_ADC_CHANNEL_NUM,
 };
 
-/**
+/*
  * enum cpcap_adc_timing - cpcap adc timing options
  *
  * CPCAP_ADC_TIMING_IMM seems to be immediate with no timings.
-- 
2.25.1

