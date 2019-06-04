Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91033E8C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 07:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFDFsJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 01:48:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34966 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDFsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2019 01:48:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so10352347wml.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d0PHWADGUTRHP3RbtVmcCFQIV5Xx7EXkRTIqij8bmTU=;
        b=AprUw2fUY0LjS5Diu/tR2Pmn7vwhaxX8wO278qS0E1kpmPhfqoJ0SXgBwesswQaVj1
         8PK7CdzlaqoLFTCdNpyPgYKJiTifXUzb7GhCqfnJ6N/EE9NUs7tNdhJ2uxK5+rDjUaBJ
         t2T42Okzeb79umghXaLPG4nfl0wp2e7t7KThJk2vD2Y6jbt5zzprKHpoAdfhMCbn1WcR
         v2cr1nwtmyUGeQfjsfAab/OslH0UZawmNrfbyyqZ1s1NEfYWnumslps++LeCw3VIhhyp
         sjPlWOQ75u6UuUF6C9guxJgimDoB9IPQFkMSHf9aYodOQwamPQubvdlKUlGoeisaMxAh
         Kwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d0PHWADGUTRHP3RbtVmcCFQIV5Xx7EXkRTIqij8bmTU=;
        b=jp6RxSIMJK8QFcYh6Cftg/jbp0Tr5gB9hMfFbodzqSHdR9hcxbXRUEz3+hFh0Cnxz5
         99PNcLTGeVrCUqa784zYyYmWtFrpSo1puKyn7kJmVDcbGOJT0MGKng5+PIYvBNVd4rFK
         VRfk2/0ZxSEewNu9VGOkAidYKPMbDDs7LwQw+7sZY7L46BGCaHJVRBA/AcBeGrD02R14
         MgP+IFzwLtCJ7XqXWOJxrpsbQkIQr8bYWaWAJ1jv4uLfrRUyplsO4h2oIO9QhpHEaa5S
         oVdQDAlCqNxDPhBjEFwkLZxFEySGJrfFL3zxAC490ljlgNCQdK6C+vbjnQ0taVuiM9bs
         /MTg==
X-Gm-Message-State: APjAAAULYRZKfCROsLdS3kn74eigG3OTCoyf6WJ0+UVMNTRjLADKPlRq
        YqrHosn/E5VlKY9cwGDJuOt1uw==
X-Google-Smtp-Source: APXvYqwIIlQozIHS1omANt46ZYA1k5oV3Ls5bT0crSJhfYkQnCeDPC78T92R6f4ncEyKrlsTMbBaHQ==
X-Received: by 2002:a1c:305:: with SMTP id 5mr17363067wmd.101.1559627287208;
        Mon, 03 Jun 2019 22:48:07 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id x8sm5149737wmc.5.2019.06.03.22.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 22:48:06 -0700 (PDT)
Date:   Tue, 4 Jun 2019 06:47:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, cychiang@chromium.org,
        tiwai@suse.com, fabien.lahoudere@collabora.com,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190604054756.GZ4797@dell>
References: <20190603183401.151408-1-gwendal@chromium.org>
 <20190603194249.GD2456@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603194249.GD2456@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 03 Jun 2019, Mark Brown wrote:

> On Mon, Jun 03, 2019 at 11:33:31AM -0700, Gwendal Grignou wrote:
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> 
> I'm not clear why I keep getting copied on this series or why it's being
> resent?

Not sure why you're copied in, but I asked him to resend.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
