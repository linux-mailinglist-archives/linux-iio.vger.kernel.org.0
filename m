Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083531818D7
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgCKMzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 08:55:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36139 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgCKMzK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 08:55:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so1760272oib.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2020 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seas-upenn-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LejFn6yYVLckCZa01sKnIbyhEF1keVyA7WsR3125o7Q=;
        b=wtgQdxKD3cCVyNcikyZruuGpQNUh73otTPL03L1Y3nG5QJ0mu8VBC07J2FFWWv7fjR
         jupqrrpiCkzvvIpgV6g0vJKpl0plw/q3q1I4eeM7xo4uYKOtlF9Zq/RKyTczVB83QoOH
         oDm6XuGKM+TP+lUY2Zf0a3zmJH/7s9QIooxvTxu0bSLJhjdz9S7RUT1jGakUV2YeOGer
         lSVa7LQXYVJFczjgZt8Vrf8Edi+Xei2X9NUapSqsEmrhjfhj9jq9oInz0UO5sEYHH68n
         LeHhnqAviCnFHeYd9fQdi8MO0lS+d/Yw4jLZ+z6/mBa6OMeuAObj7BOJnZ904CsSCD3u
         k+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LejFn6yYVLckCZa01sKnIbyhEF1keVyA7WsR3125o7Q=;
        b=ofD/lwBASg7Du8TAQFI4aEAtrsIBEYJtz6rGnHXHcrUcSLtHgNCgKhHa1avG0U2OFo
         Fc77me4puD5f/Hj5YJRzM8ywmmJ9qa0I6PXGTBhQvk5ql/wbHN12MkvN14XHqImSwE83
         xnw7aSCB8pnqRECeNK6/frxWOdw+QshrhF9XK0hUX3mP+9KI6n8Lk4zhmC2pTlgq79M3
         OXu8YeRBhB+Bm0pKQ+byC3pVajFuQ5fRnTw0p6aRXofoGEchLblHNQT3jmqPdqq1C2ox
         Bqs3HBmaJNmoGjDFbNY+AgTAGkv5B54ii7ggYwztuUS5bq7Lb5OdJrH47OhYfz1d46As
         Tybg==
X-Gm-Message-State: ANhLgQ0XVdyDkYZZ92WpBiZUToWoWyl1uvAsDJtEutTTL+temAMebFCc
        uoYYpPeJWQuE3ZHmk4fdK0Q6Aw==
X-Google-Smtp-Source: ADFU+vufBgKv3SUjns3mdHcDzR5eY0bo9nP8U3IE3Jcv7XjdqbAbV+0scTWStubhz3VmXOPTgXNkFg==
X-Received: by 2002:aca:a882:: with SMTP id r124mr1826627oie.53.1583931309752;
        Wed, 11 Mar 2020 05:55:09 -0700 (PDT)
Received: from evX1 ([2806:106e:1f:1211:ccea:c45e:83e9:af6e])
        by smtp.gmail.com with ESMTPSA id 67sm5392250oid.30.2020.03.11.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:55:09 -0700 (PDT)
Date:   Wed, 11 Mar 2020 06:55:07 -0600
From:   Enrique Vargas <jevargas@seas.upenn.edu>
To:     Chas Williams <3chas3@gmail.com>, linux-iio@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] remove unnecessary newline for brace
Message-ID: <20200311125507.GA9347@evX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

put brace at the end of line following coding conventions

Signed-off-by: Enrique Vargas <jevargas@seas.upenn.edu>
---
 drivers/atm/adummy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/atm/adummy.c b/drivers/atm/adummy.c
index 8157925af824..6eeaa1b21f3b 100644
--- a/drivers/atm/adummy.c
+++ b/drivers/atm/adummy.c
@@ -131,8 +131,7 @@ adummy_proc_read(struct atm_dev *dev, loff_t *pos, char *page)
 	return 0;
 }
 
-static const struct atmdev_ops adummy_ops =
-{
+static const struct atmdev_ops adummy_ops = {
 	.open =		adummy_open,
 	.close =	adummy_close,	
 	.send =		adummy_send,
-- 
2.17.1

