Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7763CA236
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhGOQ0I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 12:26:08 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:36442 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhGOQ0I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 12:26:08 -0400
Received: by mail-io1-f44.google.com with SMTP id u7so7137469ion.3;
        Thu, 15 Jul 2021 09:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VCPIeLGAQSi51KqlR8ncXAhDBGWQU/Qf2TsBbc5kmuA=;
        b=skUWmOti/q7oZfGS2QCLx0pEOejaZb414XByK0zykKu/N8ehlZLA4QBZfJ3R/N7WZZ
         5iT2Jo8FTzj16vvKU1QpeXUkRCwfbXelyZb+IVvjb8NqYK8KlRKmtepxMUlj4+xZhQXg
         zzhY35aph3C31FOiEeCArPldqAzlTDpHLOAv3QuP9ZWvw1dBuyogPF3wsmmyMvR9/liE
         JIdFOJ+MbjkqSPvSRWtOLdT6Y+1AfSbktPUXoj5vLSNGAaL7mrUlvJYsXDckt21W51TZ
         zpllwnneQFzATZkKUKVZCDF8OLG4VNE9WAY/XFdTEi4mMLeHTQgdrWDXZeknUJD9oIAz
         4rkw==
X-Gm-Message-State: AOAM533+kcKhmka6/Lin9tzv+HvltOnUcT9KKHBr8yei5oYvr7EWNt42
        iNNf2KEY5QbzzEHo3AmtTA==
X-Google-Smtp-Source: ABdhPJzy2uMToeJva3aDSimbcu1EnMG73hElYY0cXNXA6Bzw4Zwd39ZzLyNbeBONUjEMzsYSKydqFw==
X-Received: by 2002:a02:ad08:: with SMTP id s8mr4832356jan.40.1626366194189;
        Thu, 15 Jul 2021 09:23:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f7sm3313767ilk.64.2021.07.15.09.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:23:13 -0700 (PDT)
Received: (nullmailer pid 1187046 invoked by uid 1000);
        Thu, 15 Jul 2021 16:23:11 -0000
Date:   Thu, 15 Jul 2021 10:23:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Johan Jonker <jbx6244@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: rockchip-saradc: add
 description for rk3568
Message-ID: <20210715162311.GA1186976@robh.at.kernel.org>
References: <20210712014437.97427-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712014437.97427-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Jul 2021 09:44:37 +0800, Simon Xue wrote:
> Add description for rk3568 saradc.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
