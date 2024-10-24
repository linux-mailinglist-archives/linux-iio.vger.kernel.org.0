Return-Path: <linux-iio+bounces-11091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703AA9AE28B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F211F22CF9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73A1C4A1D;
	Thu, 24 Oct 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y3hpTisq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC118B46A
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765859; cv=none; b=qZ5OX24wN4UCr7cbQ1IpJ505JlpGoqaf0o93QNiBDkx+PZlYf4v+WzrvkjMA77GCJpAL2Jkw/xO6uynDSaY+L120LEogJnbp/QBiFFWDZLYO95yQYHW+tWoPMa3rM9l1JueaINdgclEo0K5ZxNBX9Xo0pEzCqWqVtHbGiZ2UtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765859; c=relaxed/simple;
	bh=t+79LBkE5K7kOtgkDHP2E0U6pya3PPXPEkcsiTCgG58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ2SgydrP82CLMQay0gS+VqwyjREMWmR9MO0bN2aYOCnbfLhNTe/t3YtvKzk9T/WVrhs8HSoX/g9Dsb2rbRDZK5jp0irv7ASYM7HuBw57FmuMTfqjDsE9LM//cxN170g+ap2+xFN0KvMdLsQouytpBuWWZyybULzByFjTuWf7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y3hpTisq; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so7613935e9.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729765850; x=1730370650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WD5iIHBr6DGCl84k1ANdIW3ga0JsoT+g381ZY9lF0ck=;
        b=y3hpTisqSWfLYS3pjIlX7vsV77I3gCjAxEhVnsGpMyuqcTC9i+EYKYklebaD5pdUYl
         cyIGf8fKIQEaOFRnTqoa35M+dHHv7aXmDX+D5nHHMogN3anvtgvUQkDEznORSXOUndiB
         xBOVjfT1g1bHOzThpTLf5POEb14rst+diTt+h1KcwDswUfjxM7lQx6Lp1+2dMNe15N3Z
         s6ABlBtW16+vsyjojMw0B1C2Pa7HPZ2uEzdr82Kjs9reCawXOQif3UaOootiuNaUdQGB
         Vyr+AXTB0GMVxdG/I37oy1Vx3alSmnTUQ/EdnvVp4yUZ8MWhX8MfYJ3X483IjT92z+Ad
         fG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729765850; x=1730370650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD5iIHBr6DGCl84k1ANdIW3ga0JsoT+g381ZY9lF0ck=;
        b=ViptgJmdsnMhgEPNOL8Ukdlh4BXSoZeAL7cQH4EP2HSS+B+QyRR7fw7hCkdWIGHabG
         WIucRcxA01SXU2R6JfvfRbQV3S8zOshgT0Amy82jyjPtpaLRIOVMqzkJQ4gFkfdN7c4D
         MiqmrhnDYoE6e0rUkLvpg30E9ulWguXrmhZIbjVArbW+MDmnT6jLuI+CId0Io6NH7emr
         EnCjvi15zsIbq0bCeyPMRyn25pbbob5sBG5T3P2/63MpjWtq/cOAOqGIQAaG2wHHXnb7
         2Zi6EOZZ/k0RxFHJh1ELCNo0bc9XTPmRLXyl4K4doZzJnrmYgJ0tdUqLZuT7OHQ+Rjcd
         oCPg==
X-Forwarded-Encrypted: i=1; AJvYcCW367nAlPdH0FLRWHxQneCTesHqr6KpxPKC+bXKxMyCZd588MAsh+Dlh9Yuny3nvRoJIMhFoBR12cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGaLsAv+Tjz1bCGh7QV2JovsIGP/eMSbGs2P0VSkfrz+XDkrm
	B11Iv+tQ3Ib7nllvfB+MDhzCw190RXhwCPT7hyA+2joqQcsLNZAyod0hDMm8ccbq7lWMweik2Ds
	XsSo0W7CK
X-Google-Smtp-Source: AGHT+IHXCQD3UffjE/QbdZ4kNLsZ6qSGKLd7KCMv6mNn1DegEudtO5WrZa+diDdk2HbrF0ASlLUyqQ==
X-Received: by 2002:a05:600c:1d1c:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-431841b2026mr45352785e9.30.1729765849728;
        Thu, 24 Oct 2024 03:30:49 -0700 (PDT)
Received: from dfj (host-79-41-194-153.retail.telecomitalia.it. [79.41.194.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b79esm12948755e9.47.2024.10.24.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:30:49 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:29:29 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 4/8] iio: dac: adi-axi-dac: extend features
Message-ID: <szncfysidctefmjb5u5l7kabyxa76rvuwao34nrue6menohfn2@4x7gyvmzat62>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
 <b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>
 <20241022-napped-labored-6956ce18d986@spud>
 <7a4f8c718029c8c57596d950495fcf28562c6e78.camel@gmail.com>
 <20241023-nifty-electable-64d3b42bce3b@spud>
 <172316a342407e74840894f553d7647a19fd89d4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172316a342407e74840894f553d7647a19fd89d4.camel@gmail.com>

On 24.10.2024 09:04, Nuno Sá wrote:
> On Wed, 2024-10-23 at 16:22 +0100, Conor Dooley wrote:
> > On Wed, Oct 23, 2024 at 04:56:39PM +0200, Nuno Sá wrote:
> > > On Tue, 2024-10-22 at 18:21 +0100, Conor Dooley wrote:
> > > > On Tue, Oct 22, 2024 at 02:36:44PM +0200, Nuno Sá wrote:
> > > > > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > 
> > > > > > Extend AXI-DAC backend with new features required to interface
> > > > > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > > > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > > > > IP but with some customizations to work with the ad3552r.
> > > > > > 
> > > > > > Then, a series of generic functions has been added to match with
> > > > > > ad3552r needs. Function names has been kept generic as much as
> > > > > > possible, to allow re-utilization from other frontend drivers.
> > > > > > 
> > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > ---
> > > > > 
> > > > > Looks mostly good,
> > > > > 
> > > > > one minor thing that (I think) could be improved
> > > > > >  drivers/iio/dac/adi-axi-dac.c | 269
> > > > > > +++++++++++++++++++++++++++++++++++++++--
> > > > > > -
> > > > > >  1 file changed, 255 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> > > > > > index 04193a98616e..9d6809fe7a67 100644
> > > > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > > > @@ -46,9 +46,28 @@
> > > > > >  #define AXI_DAC_CNTRL_1_REG			0x0044
> > > > > >  #define   AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > > > >  #define AXI_DAC_CNTRL_2_REG			0x0048
> > > > > > +#define   AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > > > > +#define   AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > > > >  #define   ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > > > > +#define   AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > > > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > > > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > > > >  #define AXI_DAC_DRP_STATUS_REG			0x0074
> > > > > >  #define   AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > > > > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > > > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > > > > +#define   AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > > > > +#define   AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > > > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > > > > +#define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > > > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > > > > +#define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > > > > > +#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > > > > > +#define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > > > > +#define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> > > > > 
> > > > > ...
> > > > >  
> > > > > >  static int axi_dac_probe(struct platform_device *pdev)
> > > > > >  {
> > > > > > -	const unsigned int *expected_ver;
> > > > > >  	struct axi_dac_state *st;
> > > > > >  	void __iomem *base;
> > > > > >  	unsigned int ver;
> > > > > > @@ -566,14 +780,29 @@ static int axi_dac_probe(struct platform_device
> > > > > > *pdev)
> > > > > >  	if (!st)
> > > > > >  		return -ENOMEM;
> > > > > >  
> > > > > > -	expected_ver = device_get_match_data(&pdev->dev);
> > > > > > -	if (!expected_ver)
> > > > > > +	st->info = device_get_match_data(&pdev->dev);
> > > > > > +	if (!st->info)
> > > > > >  		return -ENODEV;
> > > > > > +	clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> > > > > > +	if (IS_ERR(clk)) {
> > > > > 
> > > > > If clock-names is not given, then we'll get -EINVAL. Hence we could assume
> > > > > that:
> > > > > 
> > > > > 		if (PTR_ERR(clk) != -EINVAL)
> > > > > 			return dev_err_probe();
> > > > 
> > > > clock-names isn't a required property, but the driver code effectively
> > > > makes it one. Doesn't this lookup need to be by index, unless
> > > > clock-names is made required for this variant?
> > > 
> > > Likely I'm missing something but the driver is not making clock-names mandatory,
> > > is it?
> > 
> > Did you miss the "for this variant"? Maybe I left the comment in not
> 
> I guess so :)
> 
> > exactly the right place, but I don't think the code works correctly for
> > the new variant if clock-names aren't provided:
> > 
> > +	if (st->info->has_dac_clk) {
> > +		struct clk *dac_clk;
> > +		dac_clk = devm_clk_get_enabled(&pdev->dev, "dac_clk");
> > +		if (IS_ERR(dac_clk))
> > +			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
> > +					     "failed to get dac_clk clock\n");
> > +
> > +		/* We only care about the streaming mode rate */
> > +		st->dac_clk_rate = clk_get_rate(dac_clk) / 2;
> > 
> > Isn't this going to cause a probe failure?
> 
> Exactly. And that goes in line with what I wrote about the bindings not describing
> (currently) this. So yes, for the new variant (which has 'has_dac_clk' set to true)
> clock-names is indeed mandatory and probe will fail if it's not given.
> 
> >  
> > > At least for the s_axi_aclk, we first try to get it using clock-names and if
> > > that fails we backup to what we're doing which is passing NULL (which
> > > effectively get's the first clock in the array).
> > > 
> > > The reasoning is that on the generic variant we only need the AXI clk and we
> > > can't now enforce clock-names on it. But to keep things flexible, this was
> > > purposed.
> > 
> > Why not always just get the first clock by index and avoid the
> > complexity?
> 
> And that was also suggested in the previous version but then Jonathan suggested this
> [1]. I agree things now are a bit confusing because we expect clock-names to be
> optional for the generic but mandatory for this new variant and the code is not being
> that explicit about it.
> 
> > 
> > > Another alternative that might have more lines of code (but simpler to
> > > understand the intent) is to have (for example) a callback get_clocks function
> > > that we set depending on the variant. And this also makes me realize that we
> > > could improve the bindings. I mean, for the generic dac variant we do not need
> > > clock-names but for this new variant, clock-names is mandatory and I'm fairly
> > > sure we can express that in the bindings.
> > 
> > Right. You can "edit" required in the if/then/else branch for the new
> > variant.
> 
> Yeah, and IMO that should be set in the bindings (it would help understanding what
> the driver is actually doinfg.
>

ok, thanks, so 

so modified yaml in this way:

  clocks:
    minItems: 1
    maxItems: 2

  clock-names:
    items:
      - const: s_axi_aclk
      - const: dac_clk
    minItems: 1

  '#io-backend-cells':
    const: 0

required:
  - compatible
  - dmas
  - reg
  - clocks

allOf:
  - if:
      properties:
        compatible:
          contains:
            const: adi,axi-ad3552r
    then:
      $ref: /schemas/spi/spi-controller.yaml#
      properties:
        clocks:
          minItems: 2
        clock-names:
          minItems: 2
      required:
        - clock-names
    else:
      properties:
        clocks:
          maxItems: 1
        clock-names:
          maxItems: 1

 
> [1]: https://lore.kernel.org/linux-iio/20241019160817.10c3a2bf@jic23-huawei/
> 
> - Nuno Sá
> 

Regards,
  angelo

