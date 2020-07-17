Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45DC224120
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGQQ5y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGQQ4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB7C0619D6
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so15943409wmh.4
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5VMi11gyu7YagowBqZgb+iOtuPEVBAr50ImKPiNX6s=;
        b=nlLaOOQYdj6COawHywehL+uIslG8GGW7Zd+HR8CE/RBqDIxrYnRaXheKONmsk/d4z4
         1253X+HPxeJsfuyIVd2P1SxvASoQnF+ZjxdXfC5/g9ti2j2E8je61o06ktuvArxxQqJa
         yh919W9bswOHr1uURS4wbh2wOBiJAaL4nsHRFZfXSJH1ThZptLnYShcnAVhUvXEKk4xp
         SxTodoxyQtaFK7JN7tUzlLsMmDeIGuhoVSUbdJ7LmLjpC8Ccf/J2w43MEkmrYIIhZsZC
         HuoSVtXelnZqc9x+znqgll3nvr7TUE7ZK0S5MrDyp/FPGH7BFmtvBFv0JIXKlEjm39kX
         MdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5VMi11gyu7YagowBqZgb+iOtuPEVBAr50ImKPiNX6s=;
        b=kP5efySmZO5fiW39xOh3Rvg8RdPhcfnlPObd6ro6aTsBpbSZdZqvq0dYXEjrF6Bvnl
         oiIBoDiuMAvCJbvKFv8D4LM2YCATFmut1VQIBmzLAUBuxRN0qoCaP9ivfJBLYn+2T2/t
         ugfAC2DhtDbJjdOGzZGqn9b/i8LlDUlBMMkikpyDe4qZF9rY80V/iUEkK5WlsNIVsRzb
         aPjQWNqDxmBx+fzroq+L4N8Z7whE0tJnSu8Pthk/ZZUUGgrhjN0M9/Xm9qnnZ0QDkgNV
         vuGTC+kXhT9L+5iRHzpWe1wqTn+32+kZD+VUGKi41IYBux63dZoSczyPdOtenm0KziBD
         LAgw==
X-Gm-Message-State: AOAM530cL3xyPQqDORlTh18o4fIyFvdEktgfA4gBV8VwQcHyf54gi+qL
        2g4mQuGzhhLhM7ROL4dcLm7ntA==
X-Google-Smtp-Source: ABdhPJz/dnU1oVaIfi3DiolGTqevMFpFyFT/sUC0KZbrG5hWrZl4hIOPfOv6eihpEOTuuE/XSpLb7A==
X-Received: by 2002:a1c:a986:: with SMTP id s128mr10887191wme.121.1595004966324;
        Fri, 17 Jul 2020 09:56:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 07/30] iio: light: si1145: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri, 17 Jul 2020 17:55:15 +0100
Message-Id: <20200717165538.3275050-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

No attempt has been made to document any of the demoted functions here

Fixes the following W=1 kernel build warning(s):

 drivers/iio/light/si1145.c:192: warning: Function parameter or member 'data' not described in '__si1145_command_reset'
 drivers/iio/light/si1145.c:228: warning: Function parameter or member 'data' not described in 'si1145_command'
 drivers/iio/light/si1145.c:228: warning: Function parameter or member 'cmd' not described in 'si1145_command'
 drivers/iio/light/si1145.c:1186: warning: Function parameter or member 'trig' not described in 'si1145_trigger_set_state'
 drivers/iio/light/si1145.c:1186: warning: Function parameter or member 'state' not described in 'si1145_trigger_set_state'

Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/light/si1145.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 0476c2bc81384..37a6a59030929 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -181,7 +181,7 @@ struct si1145_data {
 	int meas_rate;
 };
 
-/**
+/*
  * __si1145_command_reset() - Send CMD_NOP and wait for response 0
  *
  * Does not modify data->rsp_seq
@@ -215,7 +215,7 @@ static int __si1145_command_reset(struct si1145_data *data)
 	}
 }
 
-/**
+/*
  * si1145_command() - Execute a command and poll the response register
  *
  * All conversion overflows are reported as -EOVERFLOW
@@ -1176,7 +1176,7 @@ static const struct iio_buffer_setup_ops si1145_buffer_setup_ops = {
 	.validate_scan_mask = si1145_validate_scan_mask,
 };
 
-/**
+/*
  * si1145_trigger_set_state() - Set trigger state
  *
  * When not using triggers interrupts are disabled and measurement rate is
-- 
2.25.1

