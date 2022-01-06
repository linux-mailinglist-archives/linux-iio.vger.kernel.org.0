Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17548663F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jan 2022 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiAFOnn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jan 2022 09:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiAFOnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jan 2022 09:43:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C295C061245
        for <linux-iio@vger.kernel.org>; Thu,  6 Jan 2022 06:43:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m21so10492192edc.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Jan 2022 06:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9PVki9YoUZusEiSyxrAuehqQ5tJSUbTdhYvQyRox3s=;
        b=K6rrtpfL1J7LQP3iPc6fGPlqO3PdkYLaJ0fAqqbFEPTqm3CWW9EbEYPxCujHtlSPnx
         m+x32Gh5KOC1JwZZVaD0mShSF/9vf0PUSrZVChPfaKL0fKVXEhvKoW4so8h6Mo/Bgt7b
         fj5XUja4/5BfHjaoYoMmUgseqgsFYAX94sYEYzvGi8//0LNPPwQTRHP5iZevDlK2nWus
         TJnnfvOcZCSpeOnQhL32BqIxZeDUcYBd0TTzVDgPdSRvTBj14QpupcifAFxMk/0rBKGd
         NmO3kvRREZft9vI6THockr4AHRFnj3vT2HD6mxOdvLZp5HN2PzjD3HJh4K9Afopf3tKH
         ENCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9PVki9YoUZusEiSyxrAuehqQ5tJSUbTdhYvQyRox3s=;
        b=0wlrS6LnM1ESEfovAd6J1EnDzN+UGxgz6uuHrDkhT2rlmUiCUKN6BnfO6qs5gPRW3l
         dseGHF7I1lFwrPcQanrX5kSObOAvAGjgcNfMMIJ2trgkhLHXdUU8/KIXjXKTa9maZF2p
         XRyeeN8y52WfM4k8Xlb11NKPls2gLyrqIVhW9MONZlEqNhkwHyuecoMp8rTigAEH58sJ
         FsD2tAXG/wyKXRDJ5jINhjjvP3u/EYlj8jTZM5MHU3bqTC2c94E9YopHXDzXxKKs2BXI
         drHr5AAXDF1L35J0smW/yXyhaunobAfjfXTTQM48CY3PCbskxF5GK0TRruZVvKLubcgQ
         vI/A==
X-Gm-Message-State: AOAM531iTNoxdsMcIvqga6cU3Eo4MUesS+8rvJ/BM5cwv/F7g5/rS6Yk
        aSAtAPKweYGEJpaBOhEkuNuLTF2L9A9K7H2/hkQ=
X-Google-Smtp-Source: ABdhPJwwEVYYuS3KzkIMpdVHHZjURlKwEvDgcLCG04Uv6AtRdVihUdXSFf0g2JSnEzX6r/kWQz+BKefPbVXPrZYJpo0=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr46264847ejc.497.1641480212262;
 Thu, 06 Jan 2022 06:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20211230193331.283503-1-jic23@kernel.org> <20211230193331.283503-14-jic23@kernel.org>
 <CAPUE2uvay_vh5q_Dw7Xct1HpgMup6MMnoS1w5e1bghh2r75b2Q@mail.gmail.com> <20220106134127.000035f0@Huawei.com>
In-Reply-To: <20220106134127.000035f0@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 16:42:56 +0200
Message-ID: <CAHp75VcQjdgLe2fX23g9UOneQXQrrkGWwpTqD=0bgq+K3B+ZNw@mail.gmail.com>
Subject: Re: [PATCH 13/13] iio:st-sensors: Move exports into ST_SENSORS namespace
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 6, 2022 at 3:41 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 5 Jan 2022 10:43:49 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
> > On Thu, Dec 30, 2021 at 11:28 AM Jonathan Cameron <jic23@kernel.org> wrote:

> Could do IIO_ST_SENSORS perhaps?

You guys beat me up to it, I also came here to make the very same comment.
+1 to IIO_ST_SENSORS.

-- 
With Best Regards,
Andy Shevchenko
