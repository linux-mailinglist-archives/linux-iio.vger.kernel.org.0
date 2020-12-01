Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C992CA2B3
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgLAMaT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 07:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727908AbgLAMaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 07:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606825732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9+U4BHQe18gs1kYiI8Czm5PGqPIcTicNfez9GNjNuQ=;
        b=ZxSOa0zyn+PJG1MYcGAgZle0E3YIAi4oijhP8gc6EMooQeQK1WUpNw9KXkUT6Iw0QzF8CM
        3cWy2siAThKve3R/bIznEagcoZSD8MdgJu7UvvjXl/mD35PYdvUPQMuFRBLRkFoLmVOHlt
        6QrxPzxxIHxrmIoYG87mUmZu/29e1vg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-k74ouHApPZ-0VFg6HBBFJw-1; Tue, 01 Dec 2020 07:28:50 -0500
X-MC-Unique: k74ouHApPZ-0VFg6HBBFJw-1
Received: by mail-ed1-f71.google.com with SMTP id z20so1244836edl.21
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 04:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D9+U4BHQe18gs1kYiI8Czm5PGqPIcTicNfez9GNjNuQ=;
        b=QHPjWL0/E6QFOXAbnFHMgbkDmSQhXFxS5y/Yl33Hbh6XRToHUucCl0dmslQz6eiwRe
         3gns8ra1S+WmMwq8qC0XxeOlSNwKVc2mta1+wJ1OgN2dCqFW94R3dicQq4mxNLk5FSD/
         nMcwAI1xsEpLQLLjYtn2JvHhnw8NIqBuDS1bLS/pntGW98FXRs9kUy9z3QDZfUGO98cf
         l3RLf9kGQ2S18Zdqqk0v3ifwOVXsKelw0UNWeg8eQJg+vJQXXhplEfH6kcy7F1KrdcRs
         WQ0oXjxlfrWEz/CqVrLCzFh5rdybFvenQTiefNhKU5P/kXMV2VdruKFtRQ+xQ0l5PsTS
         D+IA==
X-Gm-Message-State: AOAM5308WOeVhhK2Lfd10HxYqzhkdt+uGoa15CnDL5ZJF3uvX2T38rUv
        9Qt3QGWxBU9m9o5liLvsaPu45k71++Tf57yjuAVGBOJ/Fa98mO21I6iz9Ihwe9w6CYWwx5Gp2z4
        w4+5leQD96Kz80/EtUFjnRm/Bf9mFezWI6a+6DI5+2ADqz3vuVLgREApfw67tiuzD/CvK1U5C
X-Received: by 2002:a05:6402:229b:: with SMTP id cw27mr2754434edb.23.1606825729094;
        Tue, 01 Dec 2020 04:28:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv0h4fqcfcry+OvN/H2CNbkAbAGUd4sSTBufLC/l8qSxs9kjoQUX/xMAHjZRdJE+Zb2FlMeA==
X-Received: by 2002:a05:6402:229b:: with SMTP id cw27mr2754410edb.23.1606825728813;
        Tue, 01 Dec 2020 04:28:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y17sm753418ejq.88.2020.12.01.04.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 04:28:48 -0800 (PST)
Subject: Re: [PATCH 0/1] iio: core: Copy iio_info.attrs->is_visible into
 iio_dev_opaque.chan_attr_group.is_visible
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
References: <20201125084606.11404-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2a20cf21-d483-d41e-6ff8-95ae23d230c2@redhat.com>
Date:   Tue, 1 Dec 2020 13:28:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125084606.11404-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/25/20 9:46 AM, Hans de Goede wrote:
> Hi All,
> 
> I wrote this because I was planning on using is_visible in a driver's
> attribute group myself (1). But in the end it looks like I'm going to
> do things differently.
> 
> This is still useful to have though, both for possible future use of
> is_visible in driver's attribute groups as well as to make the current
> usage of is_visible in adi-axi-adc.c actually work.

Jonathan, any opinion / remarks on this one?

FWIW since I no longer have plans to use is_visible in an iio-driver
myself I'm fine with dropping this one, but:

1. Being able to use is_visible in the attr group of iio-drivers
seems like a nice thing to have.

2. There is an existing use of is_visible in adi-axi-adc.c which currently is broken.

Regards,

Hans




> 1) I was planning to add an (optional) in_accel_location attribute which
> would contain "lid" or "base" on 360 degree hinges (yoga) style 2-in-1s
> with 2 accelerometers and where the kernel knows the location. But given
> the recent discussion to use label-s for this for proximity sensors,
> I believe that using label-s here makes more sense too. I will write
> a patch-set for this when I can find / make some time for this.
> 

