Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675BE40D228
	for <lists+linux-iio@lfdr.de>; Thu, 16 Sep 2021 05:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhIPDx5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 23:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhIPDx5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 23:53:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27781C061574;
        Wed, 15 Sep 2021 20:52:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m21so5961128qkm.13;
        Wed, 15 Sep 2021 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8pdCgT8Dk9nwi5cOThdaZCDIas189n8MqwW6echK9k=;
        b=iMEBrtz94FcLe6yTN+V8qvN1F2TF07AfZN8/epMBz1JuEkvAACV3q1W+GVdmfo5r54
         bg//8MWY6mTmX9lQC2Kp25KUDBA1EPKA5JlE5ZvNPGF/W8cCJyS5CQg2Asy5KM8G0qP8
         j+r6IMN2id2P0wQtIbzl33v2wIQA2cOhsEYVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8pdCgT8Dk9nwi5cOThdaZCDIas189n8MqwW6echK9k=;
        b=xOSMJqMCa1K53ISWxDVr9mCYpxZjRXuRsqlXZpPmnwOzfCjwN9cVrSdUI5C0WYzMLk
         sdVG5lwx9nLU3+qutXQctxtyV3LTnuInnVrFKLiCBceFCwbEBaEpitYhwRFqX8mbT0pI
         k3UZfccga+tpAewOlec1QjG/qrmuVzkg/lejfDoKOAq55qNuTtj0tu/B+v7pQ8ctWZ5Q
         /zK8ZBvmVwkBGuPQNfb0VUs0C0r9a387KamAZVLix9xRRZNmeN/3MZirMBR5niuSfxKX
         sSbfm2n1YG61t5910AWMgjTeOMddXsdS7ynPQQniqltnpJcv4Vn3nXo0Vl5ubka03cZR
         cCiQ==
X-Gm-Message-State: AOAM531nykOjtd49j33J9TUdPjrPLPP1Y55PPgB/s4q1QSGa22iq3kG0
        8M0VuQCqwxZvBgxYsWY746LpLrvFUr7euJnmzr75hF5b
X-Google-Smtp-Source: ABdhPJxoby/8H50notx6irHNgeSday5LPM9+rzgXxcx7N4BW5dKsUnLAMdsFv2lQFsB3wKXccEJdgJUW4SCIhBWwhqU=
X-Received: by 2002:a05:620a:140c:: with SMTP id d12mr3200243qkj.381.1631764356048;
 Wed, 15 Sep 2021 20:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
 <20210831071458.2334-5-billy_tsai@aspeedtech.com> <20210905153339.751732cc@jic23-huawei>
 <20210905155029.3faa2c04@jic23-huawei>
In-Reply-To: <20210905155029.3faa2c04@jic23-huawei>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 16 Sep 2021 03:52:24 +0000
Message-ID: <CACPK8Xe4KifkDxm0H6LtpCJZ1n07GLvxR_nF4Cfy5+4WXn9Z6g@mail.gmail.com>
Subject: Re: [v5 04/15] iio: adc: aspeed: Keep model data to driver data.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Sept 2021 at 14:47, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 5 Sep 2021 15:33:39 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Tue, 31 Aug 2021 15:14:47 +0800
> > Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> > > Keep the model data pointer to driver data for reducing the usage of
> > > of_device_get_match_data().
> > >
> > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > This one starts to be impacted by the fix (as its in the context).
> > Rather than making a mess of things for linux-next etc I'll hold
> > off on these until that fix is upstream in a few weeks.
> >
> > If I seem to have lost it (it's been known to happen :( ) then
> > feel free to poke me!
>
> Having taken another look at the rest of the series (and Philipp's review)
> please do a v6 starting from this patch.

I'd recommend against the practice of half applying a series. I have
just spent a good chunk of time looking at v6, and wondering why it
won't apply to any tags in Linus tree nor to next.

(It was made worse by the branch you applied them to not being part of
linux-next.)

Cheers,

Joel
