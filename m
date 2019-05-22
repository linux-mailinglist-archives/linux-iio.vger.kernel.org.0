Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA23825DCE
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2019 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfEVFx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 May 2019 01:53:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39204 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfEVFx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2019 01:53:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so762893wmk.4
        for <linux-iio@vger.kernel.org>; Tue, 21 May 2019 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5gjsqjo7IX+MYjphdtIkAMMrTXCVUSggkJvGSotJJTQ=;
        b=nSudSti3cbNq95ZgFSRAecS+O+iIU59MPEEHCRSVybrADbuZzF5mtNDtpEcL7L4jDG
         Gf2k3iVfd09ImO2tUauH5r78a1zIQCy/yZhwx4YCUEfytpwf5TrHPC0C5EjZpvU7Tx1e
         GIsjjkObImxGfY4Z/eqY7Z2npXSGGSEfzsM29qYIVx+haNOP9fMk6BoppQE6peAjmKG1
         I6VrmS5zC9uQdJ2C5QV1x+AJ2kqL5JgdkWgHolDkckJRu+IdYvX2atO2zp21hTxH5eQW
         Ik5Fn1RalD1gDMXJYyKQjL823oybPJay4I5m7RyRy2EXVUEb29QDjg0BlcYTTAT7wjEJ
         OByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5gjsqjo7IX+MYjphdtIkAMMrTXCVUSggkJvGSotJJTQ=;
        b=g+t56wH5Bh88CyrVXRSJdhn57jncTwCIn6Bs5sSeOSKCC+KxPxUlCHrOk5pB0I1NBV
         Y4KUaoo7LB92JQ1bjP4Nn2oHJdCQFIqPmPXgNFeJ1JuxQWwFEIsm4j+82vIeRMRxMvYs
         4wEdhJI/XEXXWpE0qbbgV75kMsf6CW2LxbiQUrJ1WhYtx5pMxap1jvkmJt5citi+Ptm6
         GuNoi42K3yQK+YmoWKF2Jo2C3KaudChO1uq6FPslp21y+VjEqiQdUy9ufT1HLvRE7tA9
         ALqUn1YFJaXW5O0Tq51BVqfCOCBa1/nDfE4O0AjYCgmR4MA14Xy9JDuBMtPMyEyIKQdx
         B0LA==
X-Gm-Message-State: APjAAAXE+s0ieHI+eBipzxs8avonCxNOhK8P+B4yTvHzR7zudNtcXerQ
        LRDVUyOic6A7Ju0K5XRkw1OHEQ==
X-Google-Smtp-Source: APXvYqw0VeHmbRFUaVBdAsWdfo5a4BUlWDZQeqyEOri4Oo8A4cuG+M7gb+hFRspLGJE99Uxe95GC7Q==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr5741383wmh.62.1558504405746;
        Tue, 21 May 2019 22:53:25 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id y4sm3465996wmj.20.2019.05.21.22.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 22:53:25 -0700 (PDT)
Date:   Wed, 22 May 2019 06:53:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190522055323.GD4574@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 May 2019, Fabien Lahoudere wrote:

> Le jeudi 09 mai 2019 à 14:13 -0700, Gwendal Grignou a écrit :
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> > 
> > The source of thruth is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> > 
> > That include file is converted to remove ACPI and Embedded only code.
> 
> Hi, 
> 
> I reviewed patches of the series and they looks good to me.
> 
> Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

Thanks Fabien.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
