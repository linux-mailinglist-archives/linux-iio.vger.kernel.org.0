Return-Path: <linux-iio+bounces-9162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4B96CF7E
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37DC288DA6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086F18BC0A;
	Thu,  5 Sep 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnbhqUm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C518950D;
	Thu,  5 Sep 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518355; cv=none; b=F+/n5PG3X5vEeBVV5SiZD6tiFB/sUI8DUFhJEgXRiVCKPNnQcDcVD9aBn3L8Qc+L/URqGKTh3YcyD+Y8pH/idWRC5+d+ozl5FtFl9Y97UnEcwIOpiTmZqAJjZ7Gj8+2TmtWcb3sM9VBE8LV+t2pLZ5tp6sFoC6HlbD8je9o+QPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518355; c=relaxed/simple;
	bh=2kvLgZSNSvnNIYgFXbp2REpmmaeH1UenYwG7tEWJAQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIlCD2TbIt+GtwzcvCljRlpOhdWXV8tAd3TPEyYL5OzBhlL9V07Rl30m6upNzpU5CIdsg9BdOY4acAwWPi4UJFCcTqUHsfWWS/Gq1eAKDxurwrEYKV2g6Qj/2thLMOvTmAJ507ZLn8vA7xXUlAYvSNiPpwXkyNDjFYNCDXnRfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnbhqUm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898E5C4CEC4;
	Thu,  5 Sep 2024 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518354;
	bh=2kvLgZSNSvnNIYgFXbp2REpmmaeH1UenYwG7tEWJAQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnbhqUm/IIxKsOeHPYZvElQkW4FPs4nH335acd2BvI/6FSyeFeCAsN3SqlK2VzFtf
	 7t1CTOyGcuwLVo+U4NIyZaVI4QsmfiD6JlvqEF6bzonYxi3K1o67iq1kCGDzkPikap
	 wAv6dM3Rqb5PMk/+rvWqQ1pxdwP1pywCTqZmSTPs9MshWcUEl7BqEFYJ0l/eaHt4uf
	 jNjMw1zel0TcP7AhvRysIjc15BXz5Eeeiqy6bOzTyLYjM2Syl1fgoACIKeh8T+j5fC
	 pHZSLOaDia0abVduwJhECz7evzUJYhE1Vfwf4ocWYjuT/CVJkimb7Jdj2rUYcJrdTM
	 QugGssGykRtDg==
Date: Thu, 5 Sep 2024 08:39:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
Message-ID: <tpl7wufkyog2bvnhg36keczeokadxkqkcoiy5qjscsoosxsiql@6a3ghbo4pc7f>
References: <20240904072718.1143440-1-aardelean@baylibre.com>
 <20240904072718.1143440-8-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904072718.1143440-8-aardelean@baylibre.com>

On Wed, Sep 04, 2024 at 10:27:15AM +0300, Alexandru Ardelean wrote:
> @@ -114,6 +124,45 @@ properties:
>        assumed that the pins are hardwired to VDD.
>      type: boolean
>  
> +patternProperties:
> +  "^channel@([1-8])$":

Drop ()

> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number, as specified in the datasheet (from 1 to 8).
> +        minimum: 1
> +        maximum: 8
> +
> +      diff-channels:
> +        description:
> +          Each channel can be configured as a differential bipolar channel.
> +          The ADC uses the same positive and negative inputs for this.
> +          This property must be specified as 'reg' (or the channel number) for
> +          both positive and negative inputs (i.e. diff-channels = <reg reg>).
> +        items:
> +          minimum: 1
> +          maximum: 8
> +
> +      bipolar:
> +        description:
> +          Each channel can be configured as a unipolar or bipolar single-ended.
> +          When this property is not specified, it's unipolar, so the ADC will
> +          have only the positive input wired.
> +          For this ADC the 'diff-channels' & 'bipolar' properties are mutually
> +          exclusive.
> +
> +    oneOf:
> +      - required:
> +          - reg
> +          - diff-channels
> +      - required:
> +          - reg
> +          - bipolar

rather:

required:
  - reg

oneOf:
 - required:
     - diff-channels
 - required:
    - bipolar

> +
>  required:
>    - compatible
>    - reg
> @@ -170,6 +219,17 @@ allOf:
>          adi,conversion-start-gpios:
>            maxItems: 1
>  
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            enum:
> +              - adi,ad7606c-16
> +              - adi,ad7606c-18
> +    then:
> +      patternProperties:
> +        "^channel@[1-8]+$": false


You have two different patterns here and in top-level. Please keep one:
^channel@[1-8]$


Best regards,
Krzysztof


