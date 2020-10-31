Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0673D2A18DD
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgJaREN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 13:04:13 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:36349 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaREN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2020 13:04:13 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2020 13:04:12 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C69F2300002A5;
        Sat, 31 Oct 2020 17:58:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1E41F1B55F; Sat, 31 Oct 2020 17:58:36 +0100 (CET)
Date:   Sat, 31 Oct 2020 17:58:36 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml
 conversion
Message-ID: <20201031165836.GA12341@wunner.de>
References: <20201031134110.724233-1-jic23@kernel.org>
 <20201031134110.724233-17-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031134110.724233-17-jic23@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 01:40:57PM +0000, Jonathan Cameron wrote:
> +  spi-cpha: true
> +  spi-cpol:
> +    description:
> +      Should be either spi-cpha, or spi-cpol but not both.

Do the YAML files follow RFC 2119 terminology?  If so, this is a
"must", not a "should".  (As it was in the txt file.)


> +required:
> +  - compatible
> +  - reg
> +  - vref-supply

This is missing "spi-cpha xor spi-cpol", not sure if it can be
specified here using the xor YAML trick.

Thanks,

Lukas
