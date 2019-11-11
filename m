Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0410F7FC9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 20:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKKTXy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 14:23:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44832 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKKTXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 14:23:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so7352766plb.11;
        Mon, 11 Nov 2019 11:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hMyiPGiqfzCIbwdoJWpKshm10Xf96sxNnAB97j+N96w=;
        b=nSt1U5kR6w9pKa5jHSRtw90WvjxFIDPIzb/lhes4TFCAkccJu00BgrQirXd1mUy3O7
         jAhyt61k0QzOa2Tv3tGYXR9ZyQGFQZGU4UFgXFWm2Rga+xKonnl7AUgU93mBAMrLmH4K
         WNqa7NgudMyPoc3NlG7DMtmM+rIkxzIAd0l1NSGx0o2wlWNR8nJ0heQ4Z7JesD04Rz0q
         G8kbYpRWvJ66g3Pv7BFBqy2y6s36fevFFN4Rc4XsY+5CFrKdq88/EFPswoGuE8EYyXIy
         yVOFSe6tQ/t/kQHW5/DsYYbbOWV96eTGBSvqRp/iWYeRGAdcoEfOwqU6W7/6czg8hZm/
         eKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMyiPGiqfzCIbwdoJWpKshm10Xf96sxNnAB97j+N96w=;
        b=W4uM0JxGnkcf6ZwXnThtWJ6nhYmRvOCFldtTopzW3jUKm+EZ1OKrtldGx9w5v+zEJS
         B5EGvXqihEP7NefiDKngR1owOI0VRtpsL1sXnTw5xhAZbYsYL5h2Lm70J7fCr4qzwC3K
         ZE/jONe/Kz9unyTDNAfO7T9kbhQxiIX9wQX/voUfiTONvgWtLKro2oXh7EKkLQ2pCnrK
         NoTpvDgCrvGbyuuaNKWIbZoZ2BrTNeRCw3nGmbrPsuf39rRozS1x+Mjzvd1XuQYzv+jZ
         hjQV8Szqt3OJ7z0Gx42OOBFiL8t/as1ntB1I/u4R9Tf5ndiRMrXyv/ML5QqjVQ1oRfLI
         3EUA==
X-Gm-Message-State: APjAAAXZ930n2NGMru9FBG+SjEQJbkqwRil+kaGCLXeWu3H7vB4AFRER
        7lkLdZavFkauyeVFGb+O+lM=
X-Google-Smtp-Source: APXvYqyTtZCpDJHF6XZZezNIh/nLSfeRoWevB1Pki8/AGEXRF1ibb539in1lpk6oEvtSpa3opKJdSQ==
X-Received: by 2002:a17:902:d88a:: with SMTP id b10mr13822365plz.302.1573500232652;
        Mon, 11 Nov 2019 11:23:52 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k9sm17227891pfk.72.2019.11.11.11.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 11:23:52 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:23:49 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, briannorris@chromium.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dtor@google.com>
Subject: Re: [PATCH v4 08/17] Revert "Input: cros_ec_keyb: mask out extra
 flags in event_type"
Message-ID: <20191111192349.GE57214@dtor-ws>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-9-gwendal@chromium.org>
 <b8abe5c0-991f-5ba2-daf9-de3e011e60fe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8abe5c0-991f-5ba2-daf9-de3e011e60fe@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 11, 2019 at 10:20:41AM +0100, Enric Balletbo i Serra wrote:
> Hi,
> 
> cc'in Dmitry and linux-input list which is missing

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> On 5/11/19 23:26, Gwendal Grignou wrote:
> > This reverts commit d096aa3eb6045a6a475a0239f3471c59eedf3d61.
> > 
> > This patch is not needed anymore since we clear EC_MKBP_HAS_MORE_EVENTS
> > flag before calling the notifiers in patch
> > "9d9518f5b52a (platform: chrome: cros_ec: handle MKBP more events flag)"
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > No changes in v4, v3.
> > New to v2.
> > 
> >  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > index a29e81fdf186..2b71c5a51f90 100644
> > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > @@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
> >  	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
> >  		return NOTIFY_OK;
> >  
> > -	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
> > +	switch (ckdev->ec->event_data.event_type) {
> >  	case EC_MKBP_EVENT_KEY_MATRIX:
> >  		pm_wakeup_event(ckdev->dev, 0);
> >  
> > 

-- 
Dmitry
