Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B14B221E0
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfERGjx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 02:39:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40802 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfERGjx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 02:39:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so4489919wmg.5
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Jt5wdJSrUlMimCqzmtUfOwS3RUy8dmQzUxp/EazQ63E=;
        b=dZe0LlJtaGjmsxFrB3WS6yfJAUdNu7yGh2KfFAhFjOYxyhAu7hRONM2EoZfpL0aWFy
         BBmbRuFArOn2ofe65BDJg19HRDus/FpRJeh1XQfc9P584bczswF4q7C3NjGvZX7PtAe0
         1AF63pWP3P7/pQjatnOvogqaAsIJSL+HnvxVPhzCWE6Bp3DyQwUv/nPPtejN6uRkVdlT
         1iglk5nzNJaG0BovJfM1R3QjorFnB2LqdpYIQc5ROPQxmmyoyO6HStd8E+Av/17J2HzV
         bVc4WGuIUihZx3DmekjIjr/Cr9j1yhy4xTAwGFeI1ZXHtQKpYF7vDDHi6PoI93tstccv
         tugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jt5wdJSrUlMimCqzmtUfOwS3RUy8dmQzUxp/EazQ63E=;
        b=bel59gtPbAECn4AqXWEuCoNwOHjEDntQLfRnv6SAlewDC//cjsksmeoHS7JjTxm6t2
         oR5rB+jz9CD6XXfasSzOYytolMY4y1J8Ia8xzCLyWkjzUjuMNEnKNfdmOIGRU03P1bYa
         CaFLk8OIM0ZeqFtvwKPOb/5t80vM4QvoypgtKCFppboSiurd9q2KGOs3exAjRcqSooAV
         iOhTvRNik+35QRe7z14bslYRP9hmLKbcofFTcHqTMbHO7fMLdVQvzGEF3xEMR+h1tMZr
         pufZJToup1EbToj7M2M/CaLvwv9mjYcOzTrim9LMcW5k8kTde89vTLkF8BAwHiB2BirA
         V5UQ==
X-Gm-Message-State: APjAAAW2O2f2BAfgghsYu5jGUdvuL4wucR2LjrUBfEE3e0ehZZnPtU5R
        rOwvjYDyPbzgcz4QuwbSG6fduw==
X-Google-Smtp-Source: APXvYqyMF2eXS8TN2xbzmW4LOMI5WZiw2Jc5lr+yU/TJnKmJrKCVrjm4QEnP4KX7m2d6GrlabBihHw==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr4655773wmj.41.1558161590908;
        Fri, 17 May 2019 23:39:50 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id c63sm11476790wma.29.2019.05.17.23.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 23:39:50 -0700 (PDT)
Date:   Sat, 18 May 2019 07:39:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190518063949.GY4319@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 May 2019, Gwendal Grignou wrote:

> Lee,
> 
> I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
> used on chromebook using a squashed version of these patches.
> (crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
> respectively)
> Please let me know if you have any questions.

Is no one else from Chromium going to review?

These seem like quite important changes.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
