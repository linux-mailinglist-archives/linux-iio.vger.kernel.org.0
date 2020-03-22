Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73EC18EC0E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 20:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCVT5d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 15:57:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45480 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCVT5d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 15:57:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id m15so6021603pgv.12
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nQ9eVZZkX7CNW4Rrn5Fg/rgNjC4YD968Vs0CMRGqKrU=;
        b=SfDgZrJ2myaLMUKc8v50MYhR/ORCTCARjHVrRdgFRIHRtvBbSZVJ8NrM+1Y1G8OK5x
         E0V2ZFYM6atbNEzKsRBVLbQXwArHAbHil0UgbTa+IQZ+AdlrmKuJ1omJrT8OroMEwUyS
         WBoH+Q562xyd5BSOSkf+bjpu9MlGx1IP2OEWYXJyisyKPLGFHwg/t0Q4aHlXSerSVtwW
         3k3wym1CHHEFGFAq6YSot2VjmiQiNQOTStyl1JDH+LKqDBLDwtGF2eaoawc7ZGhjEWmy
         kiUUsdWgvaQWw7+VidG9kdb09z+Tr/jUEG2fHTnTXAo2KL8Ikndi+XekJkZWZUHsSWwe
         js4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nQ9eVZZkX7CNW4Rrn5Fg/rgNjC4YD968Vs0CMRGqKrU=;
        b=hoMkpajZtYjhpoLvJOn4JbsbHgEKjrJVZ8VUEK9KY7rs75pkpAJsx+7foT74H5Wm1M
         O3JJAwP8CmhDyMfN0V5Ty3JbHSvy0az8kVtoTc7oqsJrLltNBC1AepSQOaZqLeb2GeU3
         wWTH5SjS+iha/DdpXfpG7ZleiJZyeZqK0yDkxsF0JQaJJc/RnbjKON7sqBV9d50LBccn
         Nvg7Tzsk6/dX2SiDDoNvf5oiII3E4iJMR3qC6auZ10mDduvE0K9KEdtIvOlf10ngYEi9
         pZ+EavarpzDVisW6yIGoRByxgc5v8TbJ6BFfjlnYvQGwE0tPQ79L2t8Iky/R1TtP5MzY
         ZSsQ==
X-Gm-Message-State: ANhLgQ0nPrQ4gt5FyIwE5Fmr1HmjeWHqLwW0NOEmw+l0zbqRW7kPddJ2
        IRlQ61xvowLo+GFhttfod8I=
X-Google-Smtp-Source: ADFU+vsbnf7fcnFVSV975z1+Z1h0OM42FwzqoeWHo19MTjdjzwi+zRwImmoltHMYr9KtHqY52CaKUg==
X-Received: by 2002:a62:520a:: with SMTP id g10mr20571648pfb.271.1584907051846;
        Sun, 22 Mar 2020 12:57:31 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id b22sm11068549pfi.213.2020.03.22.12.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 12:57:31 -0700 (PDT)
Date:   Mon, 23 Mar 2020 01:27:26 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 4/4] staging: iio: adc: ad7280a: Add comments to clarify
 stringified arguments
Message-ID: <469bf8db1c228913e72841367182fba2168fe795.1584904896.git.mh12gx2825@gmail.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584904896.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Checkpatch would flash a check message around a stringified macro
argument containing a '-' character. Add comment to indicate the
argument is legitimate and doesn't need fixing.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>

---

Changes since v2:
	- None. Patch added in v3

Changes since v1:
	- None. Patch added in v3

 drivers/staging/iio/adc/ad7280a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 19a5f244dcae..bef6bd1295ea 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -824,6 +824,10 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+/* Note: No need to fix checkpatch warning that reads:
+ *	CHECK: spaces preferred around that '-' (ctx:VxV)
+ * The function argument is stringified and doesn't need a fix
+ */
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
 			     in_voltage-voltage_thresh_low_value,
 			     0644,
-- 
2.17.1

