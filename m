Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA329FF64
	for <lists+linux-iio@lfdr.de>; Fri, 30 Oct 2020 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ3IHv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Oct 2020 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3IHu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2020 04:07:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F64DC0613CF;
        Fri, 30 Oct 2020 01:07:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s15so7321588ejf.8;
        Fri, 30 Oct 2020 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8FeZSR5JJEGqlwf1fe2OSNQV7ZS283nxPmYWkHwkrfI=;
        b=N1Dk0soD9CSKegS0fdxrtvzukOgfxcNtMUzCsulbTETYMXkSQtMq3iy/oHsZt52eUU
         Y8qePqycBWyouhZczH150ALf3jJGydo9QIdasWbWpnLmD4WSvNzuo7nkRhN7IGL2rdQJ
         Z9+Yo2PTrpz5mXp06pdr35rX2STP3zT4AzvDbaNp2ZqaIVA0zwQHzSLB8gxaHsCncHbv
         4uK3tApkXdBgZtYf3ZClt3WP7WTSfAZz01LdBrwrc4yCri8dna5IzNXHCyN45tF2wY/n
         BZgc8CPlMZQDGQj6JDRQeI8LtneyR6aNAYFOxNZ0cKMcUMW+2S4VfFmWO7fV6JV74Oyv
         IqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8FeZSR5JJEGqlwf1fe2OSNQV7ZS283nxPmYWkHwkrfI=;
        b=aUEY3suQyod3hmwz6tQdsXPpF/4iImzh5DSl9gqi76Lv00TGHTWNDCQChu33uofDVL
         QuJFNdhMGONizkrfxNPL3vQZxsIjv3zsaTmXDaiKjTCt1RmuxSsrEgfCCrxXBf0/lPmW
         x9Vo8J5dksTJxOX5A7IrQAYeXQubHYa+owja4snOZh2AF+bqA+n32FiW2OytNDCDRhEf
         Oy6fxeIVjIoZCURRTCOuDBzYUR2wi4nBApkuiyxPt7JBDNBIsuVWQ3VP7Ss29sWDvoHR
         XhXBHTxVR9V8GvqHtwkOayJ3aCymUgMN0cJZ6gTB7PliO6/pK4Snqm2o6rRbWQPDTSzL
         DVgA==
X-Gm-Message-State: AOAM5326wGQtCo78piHek8A4vcqpJBsO0aAJCfm1LNIVawigpcMWB7lu
        Kt6EhEYnIfy9n2edgsZ2o48=
X-Google-Smtp-Source: ABdhPJxv6SUC8utzKVS9G9mWsefaki08dPetrAgRpX+nZMlB1C4vxJg53ikjJrig5XN+MtLQnfA9Vw==
X-Received: by 2002:a17:906:31c6:: with SMTP id f6mr1314210ejf.164.1604045267897;
        Fri, 30 Oct 2020 01:07:47 -0700 (PDT)
Received: from felia ([2001:16b8:2d02:400:25af:1ff4:dc3:177c])
        by smtp.gmail.com with ESMTPSA id a10sm2672299edu.78.2020.10.30.01.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 01:07:47 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 30 Oct 2020 09:07:39 +0100 (CET)
X-X-Sender: lukas@felia
To:     Sandeep Singh <Sandeep.Singh@amd.com>,
        Jiri Kosina <jikos@kernel.org>
cc:     benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v8 1/4] SFH: Add maintainers and documentation for AMD
 SFH based on HID framework
In-Reply-To: <20201009200138.1847317-2-Sandeep.Singh@amd.com>
Message-ID: <alpine.DEB.2.21.2010300902220.16621@felia>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com> <20201009200138.1847317-2-Sandeep.Singh@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Sat, 10 Oct 2020, Sandeep Singh wrote:

> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
> document.
> 
> Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> ---
>  Documentation/hid/amd-sfh-hid.rst | 145 ++++++++++++++++++++++++++++++
>  Documentation/hid/index.rst       |   1 +
>  MAINTAINERS                       |   8 ++
>  3 files changed, 154 insertions(+)
>  create mode 100644 Documentation/hid/amd-sfh-hid.rst
>

I do not know where something went wrong here, but it seems that
the git commit 302f0dad8c97 ("SFH: Add maintainers and 
documentation for AMD SFH based on HID framework") on next-20201030 
dropped the addition of the rst file compared to this patch v8 here.

See:  git show --stat 302f0dad8c97a11abcf145ff3c70

[...]

 Documentation/hid/index.rst | 1 +
 MAINTAINERS                 | 8 ++++++++
 2 files changed, 9 insertions(+)


Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    Documentation/hid/amd-sfh*


Just that you know...

Lukas
