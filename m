Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C371A260B5B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 08:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgIHG5a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 02:57:30 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43807 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgIHG52 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 02:57:28 -0400
Received: by mail-ed1-f47.google.com with SMTP id n13so14848751edo.10;
        Mon, 07 Sep 2020 23:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=umGp2mRac5tjGgvL1953FmzEeKMsaUQqM0ZLASNYOdw=;
        b=N5fqJEZG7B7/XsNoynwNGrDwdYwKYI0k2+m058IJt7fmvML1HP74NBozLoAOSuJK1a
         QPFpJVVmpyIlvq5Y0cI2TTLsDuegaDqEDlZwjQMCeEgs+4tQnMrxhQL8BKvRCMYTyszE
         lFBbhusQq3/GjDc+QrmRifs8YIDN1mOAjgyQkPkNt8gkWt9+9O3I7yuzW1g29FiW33nK
         9REI+OURjC44wtMREFGCFzB62qT90llzw7ot+twtQfDpBaBip1oDxdp2pSf4GI5LxiH2
         MOKW/v7Y5/MRIqXnnGiWqXbbhOvkzZtJZN+G+YZro5cQXTsWexgcSPxyNP47RFaW1px/
         xFHg==
X-Gm-Message-State: AOAM533WY4OCuvvxLNCeQi+p5tOkd5iX618ycdMOipkav38oIAchdgBC
        /5hum4UfFtx126vxWkw9SP0=
X-Google-Smtp-Source: ABdhPJwQKk7dDYAUqS1F8cS+l02dQ8Fkn0v4UEjEo7y2l4To8N85pyzNNjSurB/LEnao9OgD3/0vtw==
X-Received: by 2002:a05:6402:1859:: with SMTP id v25mr16745883edy.118.1599548245356;
        Mon, 07 Sep 2020 23:57:25 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id r16sm8407822edc.57.2020.09.07.23.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 23:57:24 -0700 (PDT)
Date:   Tue, 8 Sep 2020 08:57:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFT 25/25] ARM: dts: s5pv210: align DMA channels with dtschema
Message-ID: <20200908065722.GD24227@pi3>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-26-krzk@kernel.org>
 <25178674-e4af-ba35-b7f0-42091208e0e8@live.ca>
 <BN6PR04MB06601A7FC9D1A697481EA37FCB290@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06601A7FC9D1A697481EA37FCB290@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 05:28:54PM -0700, Jonathan Bakker wrote:
> Ah, I figured out why the dma stopped working.  In s5pv210-aries.dtsi the dma's for i2s0
> are overriden to use pdma0 instead of pdma1.  That also needs changing for this to
> work properly.

Indeed I missed this, thanks for review and tests.

Best regards,
Krzysztof

> 
> Thanks,
> Jonathan
> 
> On 2020-09-07 5:17 p.m., Jonathan Bakker wrote:
> > Initial testing on both an i9000 and an SGH-T959P are showing that the audio has
> > stopped working with this.  I'm not 100% convinced as I've had DMA issues in the
> > past.  However trying to play something just results in a hang after 1.5s while
> > it works just fine without this patch.
> > 
> > Thanks,
> > Jonathan
