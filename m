Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B6156552
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 17:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgBHQFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 11:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgBHQFE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 11:05:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB8021775;
        Sat,  8 Feb 2020 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581177899;
        bh=Euyw5YRT5MdLDsoMxRjF1gQchnvFaODdk1aaTO+peYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I+IdUU7oB1pSPUncTKinXOjnafiCdiuY0GQwjCJZdsn0treXSpxmi9pPMiVZkZXsa
         uKtTbctn0wx59Zg4drSSoyQBLngCXC+wraY2H25POLakUFeA1rFaeWSLeLebfvblHA
         c4ui79vD/0uKZwhsZnNdadb4UAW3APjn4E+N8gQM=
Date:   Sat, 8 Feb 2020 16:04:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: sd modulator: add vref
 support
Message-ID: <20200208160454.0f153bfb@archlinux>
In-Reply-To: <20200204101008.11411-2-olivier.moysan@st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
        <20200204101008.11411-2-olivier.moysan@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Feb 2020 11:10:05 +0100
Olivier Moysan <olivier.moysan@st.com> wrote:

> Add vref supply support to sigma delta modulator.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../devicetree/bindings/iio/adc/sigma-delta-modulator.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> index a390343d0c2a..2afe0765e971 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> @@ -8,6 +8,7 @@ title: Device-Tree bindings for sigma delta modulator
>  
>  maintainers:
>    - Arnaud Pouliquen <arnaud.pouliquen@st.com>
> +  - Olivier Moysan <olivier.moysan@st.com>
>  
>  properties:
>    compatible:
> @@ -21,6 +22,9 @@ properties:
>    '#io-channel-cells':
>      const: 0
>  
> +  vref-supply:
> +    description: Phandle to the vref input analog reference voltage.
I note this in review of patch 2 but in general I'm not sure we should
be introducing this for generic devices.   It's fine if we have an
explicit compatible but there is no reason to assume a generic sd-modulator
uses an external reference.

Jonathan

> +
>  required:
>    - compatible
>    - '#io-channel-cells'

