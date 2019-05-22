Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9825DCC
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2019 07:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfEVFxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 May 2019 01:53:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41646 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVFxK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2019 01:53:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so736296wro.8
        for <linux-iio@vger.kernel.org>; Tue, 21 May 2019 22:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AHUIOEByr0m4e8bmYKW9unkrzC9v4z2NQ+RPUysVTIM=;
        b=rIvrTlaAD1pLZoNAm/8UsZc40zqWwcdIuRSZI4meDNRFXqHG2OQD7koy1hVMkWXOUE
         QNeK1pGllRWZxezOJHvyyQj5ZhV78Jr9a/gVLLQT+CBFO2WFbY4yfBz9v+AcE9xOScFp
         pv8Lvkq6M9UF/PWeNFnfN9NJc5NeMgP2m9GZj11ejOkKQvKDETcDTQDYUNn9w9iu+i8w
         dq0UfI1Lw+Sc+RMWwk0XfpfUtoVyvq+a+R0j1h6qBz3Tg37S+2YnPBuJZyOjcTriI4dr
         G/XUSurOODzJOS0LSuuOzKp4euciSkNuFH6jPrfKWHrJQAZ65+5qJlaUM+bt+WFth7P+
         W5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AHUIOEByr0m4e8bmYKW9unkrzC9v4z2NQ+RPUysVTIM=;
        b=a07lCBWd8+D99s53pw4u4WgL1dR3YItL7vzpBWfukzU5/weMb7a/9iSAt3+GVSLobJ
         Xe3COP8BDA0LfBUP8tHeOavUfpNQrkx9OMCULVsNcE1/1HIP9iRtOTibVTHMv533bSBv
         obZu+27GcAsfLy/a07GYNqealPU7uzDG3JYpk1iGyE9AvD6k9v/e7esXYgH9fPl6Zhyr
         vdff/bS+jwH6+h4IETdIW1B3KGRcfUNMxgFw50GVTv2PTKweJ9UKyb+n/I2kKEowVGUq
         8DTNl+4s6DqlH4K8+p+JAMelbHQMJRwGy22viakUyKLeueW/QpVvXwj/U1uRy3Ni45cx
         mzIA==
X-Gm-Message-State: APjAAAWsGPOHbCa3EERF9guJwfu1xYS3EV5+qyuysMXFxigYjG/GR51U
        rNcRvTUWaWYuEilGpljwwNY51g==
X-Google-Smtp-Source: APXvYqyXvQ6YlCncCaZyohVXqePSWI1HJn2NNbAQ6uQJ/JWVBjAhrtNXT3/rA0VJbHm2Bp8ks8sTHg==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr1612015wrr.32.1558504388344;
        Tue, 21 May 2019 22:53:08 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h8sm9733712wmf.5.2019.05.21.22.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 22:53:07 -0700 (PDT)
Date:   Wed, 22 May 2019 06:53:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benson Leung <bleung@google.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190522055306.GC4574@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
 <20190518063949.GY4319@dell>
 <20190521174438.GA2821@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521174438.GA2821@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 May 2019, Benson Leung wrote:

> Hi Lee,
> 
> On Sat, May 18, 2019 at 07:39:49AM +0100, Lee Jones wrote:
> > On Fri, 17 May 2019, Gwendal Grignou wrote:
> > 
> > > Lee,
> > > 
> > > I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
> > > used on chromebook using a squashed version of these patches.
> > > (crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
> > > respectively)
> > > Please let me know if you have any questions.
> > 
> > Is no one else from Chromium going to review?
> > 
> > These seem like quite important changes.
> > 
> 
> I've gone ahead and acked the whole series. Enric and I are OK with this going
> in for 5.3, and as Gwendal mentioned, he's landed these changes into our
> production kernels for Chrome OS as well, so this is what we want to sync on.

Wonderful, thank you.

> Let me know if you have any other concerns.
> 
> Thanks,
> Benson
> 



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
