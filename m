Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448741832F1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 15:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCLO10 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 10:27:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42128 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCLO10 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 10:27:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so6398082otd.9
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2020 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seas-upenn-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0OR79l8awnCWEsFtkKq9JgDzwwDGvBfUvW5RRWKJYms=;
        b=MPJNhViyHf9HE1gryTmtKi7mxV8tbDG25XOMje9/qAV+r6nMXYwuKYEqgTWecP2/Y4
         FnZo62MbkhX35o0qRRXQLjkckMqpAwSRqdrppkrOhhy0NVd6AI2jD96UUSNUX0JlZJc1
         hg6cWmpfKCa4j8gSpvCx2slTQRg/HHzgA4MB2TRUVfZJfWJJPUHJMIGDH2RFtOHdGjLQ
         6C9pU0cX96Xuu/wYKXlFK/+6Zk9AguKil1kqD10N4BG4xvh7a8Fvt2k+3Dj/HuHmYWpI
         Cdv6PfXjK9LbpMCcRgVAGiWSI4JKaP19LatsAezu9d3UxW+b/dIah88KY6gMzVh2uNZY
         lT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0OR79l8awnCWEsFtkKq9JgDzwwDGvBfUvW5RRWKJYms=;
        b=kuhGtycDvlOV8jTrPjneWuW9jjQoNUGZsquCPC2VMUYET09gA35EgDa7EPywOWVjhh
         qhaLUZ3odOd4lvrIuU0Rrvu0RkT8/VpmLQdMwHcehUfVgsCI9HGwU/vQGFcNUyfJ4LuI
         9/CW4jlDgyUOwgviGyqbM0JjHm+h9vOLOCTOOx4yc6iQ5g/JWM2BBSrNKuPM11W40R8d
         gKFMdm3jYHbQH9dm/eyDmh1lVF9d9zEyzz3UZpfxbQX08otIeTPmA43cMnYuS656mdT3
         x6m4ET1Jpw2VtfwYIdVL9EO+dxELInPlx8fB11oTJO2M+q5pssu57VqoR9dL9OygT77c
         4Bpg==
X-Gm-Message-State: ANhLgQ0rkjU0w3xNLLGJ1lvPOfaTAXhyDRQJweCiS5zu1HfaecHLlD2H
        taTJYfiaWJOdrXYGrM2yrcqgBA==
X-Google-Smtp-Source: ADFU+vvKnysPIT/QxyFt4oa1+JxsoHWx+EwSP1lm0u5UgDxNx2LQIvE8osGf1AqG4k1YIcMpQp4Wxw==
X-Received: by 2002:a9d:ac5:: with SMTP id 63mr1923598otq.239.1584023245493;
        Thu, 12 Mar 2020 07:27:25 -0700 (PDT)
Received: from evX1 ([189.172.48.149])
        by smtp.gmail.com with ESMTPSA id s128sm6654990oia.4.2020.03.12.07.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:27:25 -0700 (PDT)
Date:   Thu, 12 Mar 2020 08:27:21 -0600
From:   Enrique Vargas <jevargas@seas.upenn.edu>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] Staging: iio: adc: align multi-line function argument with
 open parenthesis
Message-ID: <20200312142721.GA2748@evX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Eliminate WARNING found with checkpatch.pl for argument split in two
lines not matching coding conventions identation.

Signed-off-by: Enrique Vargas <jevargas@seas.upenn.edu>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 51b1cd3ad1de..5f65d084e320 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -477,7 +477,7 @@ static ssize_t ad7192_set(struct device *dev,
 }
 
 static void ad7192_get_available_filter_freq(struct ad7192_state *st,
-						    int *freq)
+					     int *freq)
 {
 	unsigned int fadc;
 
-- 
2.17.1

