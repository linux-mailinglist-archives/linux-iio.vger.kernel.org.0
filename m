Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13831B316C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfIOSlp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 14:41:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56005 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfIOSlp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 14:41:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so7646318wmg.5
        for <linux-iio@vger.kernel.org>; Sun, 15 Sep 2019 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R91c7MHXQpIvlw2RpBm17OLmnDnHsXumrAJEzn3l8ZA=;
        b=cl/e9a1LQAfpTpgo1OjXMgXHVBqJB8x3ipXEgSMY1ubat2xvMWjQEigFtvUrR0aXTL
         xLvtDMumMry+/PNQhfcixBtvyKvWWFfAwBTDR9jH3+s8GDnxa5fz6dDGOr1rJbKlovpz
         LqVN0529sCTHD5Ua+h3b4l6M7UGaDKhdegwLZpNRnkwMZiZ+XhLqYLW5XqY6NeGbWjTB
         NfB2m+xSNmc4kW4qtDww5wVucRgjv9SeNzBTf0N0tr7bo8uLZ3vFG67cI08EgUackF0a
         n6M1WtB9NNkWJl3Tmk0J2pttW3LztcjSFhFFvYnFGTV5nyfHEJHzYu2Npk+trsPyCm9Z
         QYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=R91c7MHXQpIvlw2RpBm17OLmnDnHsXumrAJEzn3l8ZA=;
        b=qJY5i0vEZhZ21Fp1KikVYqK41+YdkQ+e20GZJ3Fz0CrBpH1z4HdtKlPQeIWKO262OK
         LwgFiwPIRYuylMA+WKmV0+q0zF75EJMhEuhofTNwzr2vGaP282EKrolBBzAICRfDk0kt
         iBu+FMsYHKFhrk9K4+Urx1ipWBkob5rMD7bjCt47YqEbrLWaJx40PrbPKn+seYBZAwFk
         HzkH8v1fzJhgVfMJsOtLMOtJnDlMRvEyLJi0pVhu615b5FIBDPdsKt+IhNbcOv1B44e8
         bqY3NXxJ9C6BQWxFMPwchQLHU4OlBYqUjd4fV+1D+S3hr4nEXbk/rwtWaXmNUeEn5Qnr
         LUOw==
X-Gm-Message-State: APjAAAXsZVNc68pvcrFlEDveixziz6qIKLMbNBlVQxzshcRRjvCyoV8b
        5fJ3fwZZrzwoSUXFn36/j2k+y+xosnaTjw==
X-Google-Smtp-Source: APXvYqzYlPWsSoW/+5ZiS8MYJa49icgbHA8AZ0A1GJ1CfUqLMk6RJCUHYZnb1EydQY3phmNnqQG08w==
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr2805575wmb.124.1568572901673;
        Sun, 15 Sep 2019 11:41:41 -0700 (PDT)
Received: from rocinante ([91.64.150.195])
        by smtp.gmail.com with ESMTPSA id d78sm10297473wmd.47.2019.09.15.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 11:41:41 -0700 (PDT)
Date:   Sun, 15 Sep 2019 20:41:34 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: bh1750: Resolve compiler warning and make
 code more readable
Message-ID: <20190915184133.GA25817@rocinante>
References: <20190910203814.31075-1-kw@linux.com>
 <20190913202413.3034-1-kw@linux.com>
 <20190915104838.0776d2a4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915104838.0776d2a4@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

[...]
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.  Added Uwe's Acked-by as well.

Thank you!

> Sorry for the confusing advice I gave earlier, I managed to confuse
> myself on what the original code said.

No problem. :)  Uwe suggested to me how to clean things up and word the
commit message more appropriately, thus a very good learning experience
for me.

Thank you again!

Krzysztof
