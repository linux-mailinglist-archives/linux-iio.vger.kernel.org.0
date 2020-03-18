Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167FB1894E4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 05:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCRE2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 00:28:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33377 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRE2V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 00:28:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay11so10618323plb.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2020 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yby+mB+m4t6+rWgz+NdAFsUfRpAwoGudrPEsW25H53E=;
        b=GC1QPTmaU4fhhDidbDtOc+AEKg+aD4AaLcCbrnW76z3DHn2OdeWguFtlDvGPNNSuw+
         fw2E0Y6R/PL5W/dk0RxSg5c7HPLuafM3vebU1yi0xiTDx4q7kF308y5fHyT/MbzimAw7
         u2BIE0eWC0UiBjH8d0+dzfE3JYLhqNmrPOxFiaCEldgqaHlW8diIzn7AixXdxN686fuV
         3Y9i7G8E3m2LQv3e8GDbXqEBdBJX3fj8DtquSCIrvve+L8O9T/wzldthMBvzLWg6/C01
         yMNLE9RjoA8H4b9IhRKKvkSZ8pqj+5e3e+R1BFbiopZK+PS8cO+ACb9h7t81u0tl4rPN
         gTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yby+mB+m4t6+rWgz+NdAFsUfRpAwoGudrPEsW25H53E=;
        b=UE9wYMaHOciqSRjaaoyXPMo6QR8jjn+JLCPUXONOdMinTJoGvF7cmpYtyFRtUv7sFi
         5PnUmW0kvahpxF29EMtItHEV2eWrTt1mMNcWH7a+gjkj2Dl2sxwQMp3hEnr/zMpQ9R87
         FrOPFPwXd9rU+yLnt8UCI4Li0+v1mJjtfh8mzjC1mWeYAcTcSPOyTcnjnv8LRF1Pdvlw
         7gsAzncWNH4uCX4iUA/qn9U2anasANGlLabc5uWJ6A5f+AAFnW/P0Lx0ohatro4ro0R3
         Tl3qXLQZlKY/cmWgrVBgXrqIsrt/yJI7MkFMZlRejYrbn2WLfrQZ7f/1H5ZFNIYNYqiA
         uvWw==
X-Gm-Message-State: ANhLgQ0VauDAFUNhhFZp7qagl1Mp7ibq/tawmGvFJhDfik0lYL8dIop/
        8cFbg3TduNA6VK5rNAUGS7s=
X-Google-Smtp-Source: ADFU+vvjD5kV+dV3vUmVyghVqK+mGfQbD/VMmbOANpS9BgbOG/YNIYYVvy6FWID4BDr+v8yqInzh/Q==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr2674077pjb.94.1584505699730;
        Tue, 17 Mar 2020 21:28:19 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id m68sm730572pjb.0.2020.03.17.21.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 21:28:19 -0700 (PDT)
Date:   Wed, 18 Mar 2020 09:58:13 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/2] staging: iio: adc: ad7280a: Add spaces around operators
Message-ID: <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584505215.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add spaces around operator symbols to improve readability. Warning
flagged by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 19a5f244dcae..34ca0d09db85 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-			     in_voltage-voltage_thresh_low_value,
+			     in_voltage - voltage_thresh_low_value,
 			     0644,
 			     ad7280_read_channel_config,
 			     ad7280_write_channel_config,
 			     AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-			     in_voltage-voltage_thresh_high_value,
+			     in_voltage - voltage_thresh_high_value,
 			     0644,
 			     ad7280_read_channel_config,
 			     ad7280_write_channel_config,
-- 
2.17.1

