Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586D24176F3
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbhIXOn3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Sep 2021 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhIXOn2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Sep 2021 10:43:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A52C061571
        for <linux-iio@vger.kernel.org>; Fri, 24 Sep 2021 07:41:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y26so1823272lfa.11
        for <linux-iio@vger.kernel.org>; Fri, 24 Sep 2021 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEmCPB/H+2IRH1D3uUE65TfiQZm6jj6AOm88el4iUUA=;
        b=mFSVz7rjTOz7zkfUaw/Ph8gnvGASSsovGMcXp3nhRU6M8xPoSKDi/0eXL8fIfigYdA
         9w/pXuZkl/fG6RTiClUCMeveytrINVp1lASEm+cIMKAKTqw8n44EKEjPTXhFHUuXO2JV
         bjzTEuHeQ4P9fJUj0Ri2MLHQRpHHqupQ/XZLF8lNW9x1MbnOl9ch9OE+Vfgj44cKUosJ
         J9++6DkZH2oAMCAU/YQ5vbbLB5lX3Epcmdcq2VoHlMN95O5g+iOGIvU+u8vOHvvaDajo
         tfKtvB6022d/sqIz6E2tai6tRltIXFTvnWtZPIUZHFk6BsrT3kXIhTp2rvLV45WT/YI8
         kSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEmCPB/H+2IRH1D3uUE65TfiQZm6jj6AOm88el4iUUA=;
        b=RfrhnXbhVaBMvfaHJ4+NTQyiE3C9cnX64vj2t5zMdaKMdbXdO3tPRobMi8WhMaVkB+
         jjzyBiq0BiTyYdppE8+sN/ASIQYEe3rzTPj+7HFut1DFOKe2QShsowTIO1hLKyTK9d2J
         +WAxK9Ov08ZbdONWX507HgMU1c0p0MYbR5YyrvUi/s8vBn7YQKJlWZpeIZCgVJzwl7I9
         rv7FxGpCKZ71AgonO0SP3A/uaZKN3aMCT//MvrOdkxoLfyVhyjBICh+TFKIML9n+Cn0V
         xD1jHmQmTNQrc8b98pAfqZzV+YtxZnf6zJKpZX2IYmy8FnDzTSliKX+rMjg44IXLyUnx
         uu1Q==
X-Gm-Message-State: AOAM533Wu6A3apVPl2MzlWaFlbTRHwlnVE3BqhFIN60XAdonF5uwLqMd
        mbLo8bvQNzMJ13NMN7NQkwQAGzCRN8wkfio9zpM=
X-Google-Smtp-Source: ABdhPJw3gZRB7vC37YFLBF4Mi2xjcgePCmSTUPI+OLtMKPwDbmc2kT7g2/WErvzo/8CRYzsoBL58XJO1Z7hKH+enMF8=
X-Received: by 2002:ac2:510a:: with SMTP id q10mr9440546lfb.450.1632494509735;
 Fri, 24 Sep 2021 07:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se> <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
 <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
 <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se> <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
 <CAOMZO5DtNkfqFAhFtzA4x+W5eEes_pHNGouX35tNL+8hfpq02g@mail.gmail.com>
 <ee5d8cf0-591f-7296-28a8-d78159f5d6a2@axentia.se> <CAOMZO5AQk4zkgwk9ALkaasFv6t68K-bO6roki1tcdgnyk0wuTg@mail.gmail.com>
 <20210923112858.000022fa@Huawei.com>
In-Reply-To: <20210923112858.000022fa@Huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 24 Sep 2021 11:41:38 -0300
Message-ID: <CAOMZO5D1gt6tFhHzTALGFAs8Zt3aBbanw0Sz93AmWHwcnCvHSQ@mail.gmail.com>
Subject: Re: Reading ADC that comes from a multiplexer
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Thu, Sep 23, 2021 at 7:29 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:

> > The beaglebone dts uses some undocumented properties such as:
> > iio-channels and iio-channel-names.
>
> Some of this comes from the dts-schema repo.  We haven't been strict in
> adding the entries to individual ADCs until they actually use them - which
> has the advantage it gives us a window to think about the of_xlate (see below)
>
> https://github.com/devicetree-org/dt-schema/blob/main/meta-schemas/iio.yaml

On this document, we have "io-channels" and "io-channel-names.

What I wanted to say is that in
arch/arm/boot/dts/am5729-beagleboneai.dts we have:

"iio-channels" and "iio-channel-names" (Note the 'iio' versus 'io').

This is what I mentioned as undocumented properties.

Maybe I can send a patch fixing it.

On my imx6 board all is working fine now.

Thanks,

Fabio Estevam
