Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE90C171FE
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 09:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEHHBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 03:01:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38295 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEHHBM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 03:01:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so5523622wru.5
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2019 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Jgc8tHCqCzHZc3qhbbI5pSp+Yx7TXVxlmwULDXcgErQ=;
        b=f5zEBuYHZeBkLFMRO2NhfXM25Cd+QEnnZaCuimuK3skx86XUNpgCO6magbg/pJIHpd
         2VCLFYSx34ENbvYzlrSGMa75iXhXuibmKPzDxRvQ6ll9yU89uNsKCB67hO9D8EJH1amu
         GKE/K5rDGCI62PTK9sxpN2EcyiFtx2pdqOP2ilQQ94Vw8wiSQGN4AgjNJkX3TJ/vAuxp
         900wcsdES0l7a9TmlDEQPYHb0Lh0hvvhiJnWo2iFUv1gFEGKMNTXK+ABnAkMBsK5Ctrv
         Mwc//YmUX/NDi5VC9SKBpG3x2xI5B2R3STAcX7xZdeLCpR7hiLf8pai8uDM37vQ6eSd1
         4srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jgc8tHCqCzHZc3qhbbI5pSp+Yx7TXVxlmwULDXcgErQ=;
        b=cHn0pB2dK1Rdzqd5fBuQcfARYBefH6sm66qt43phOheBGHbVwt77YQI1T0oHR2+NyR
         N9IdBB4YCMYDUq1KKN5TfJyH0jbwAVqLoa37IKB64mEcWdVdMUizLBOeFK6KuFwC/y5K
         r7Ef0InxNeeGnKSDEveNlsZmafYItYmh0PB0uqQxtIcEQqGoa7kCsX1/JlH99M+CpKqD
         SCQvS1WrVn5Fq/ye98UTRJNxjZprqwVa+TF9Tyh9RNYkcavf4hggVqvMMjAXIPPQZzg5
         r5BQos9IL0zDkrg6+QGOiWne9xx8z2n3ebV8im3ed7S0DeK3+o3WP9e1jHVcu+GxZv7C
         NdGw==
X-Gm-Message-State: APjAAAVt8ZG/VXpRY+HzPtZfFoB2qPDKsL711ddwfKlyMdlralVl2j91
        zy2sD0e82QcpqNwrOkICRoxt2aF1FkM=
X-Google-Smtp-Source: APXvYqzH6iM6RnE4EChPWDuvGbuVhd/S7odkzz/aRHxlQLliQCVC3T+tM0j+VmKEfslHzUm1PP9DtQ==
X-Received: by 2002:adf:d081:: with SMTP id y1mr20069624wrh.283.1557298870131;
        Wed, 08 May 2019 00:01:10 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id r10sm1802946wml.10.2019.05.08.00.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:01:09 -0700 (PDT)
Date:   Wed, 8 May 2019 08:01:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] iio: stmpe-adc: Add compatible name
Message-ID: <20190508070107.GG7627@dell>
References: <20190507143615.28477-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507143615.28477-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 07 May 2019, Philippe Schenker wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Add the compatible name to the driver so it gets loaded when the proper
> node in DT is detected.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Why have you sent this set to me?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
