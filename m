Return-Path: <linux-iio+bounces-6812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86C915008
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A781C21C6C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0919AD4F;
	Mon, 24 Jun 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c34BiL8k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B81E533;
	Mon, 24 Jun 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239726; cv=none; b=HwbixsYFj8h65TXER4hKIwcl04JY8gHqY+YjP1ZcnYKP8tC0qqpnaZw0cjZILb4SRhohRosNYuu+4sMU2K+H4EcMRbLMzA8U+4g8bWtg6iI4ZEkMVlKj6Xi5+rDHD3z47117q0+6vC/h/6x3SB/5O9D5DIw5yGUyxgGpdAjUWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239726; c=relaxed/simple;
	bh=nWmktSg+88kQ1yVIxWO07YeCbZEQqFAeFwKfadIN5NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOFTwuAk4R6VT8xMO41bC0RyoQh+6hk+vFFL4lr9zmfiMwfsTNnDHMwW7CfIc7cJYJu473ru13YnXrslk1PK+GAzDE135EMLDHBCYcQj24qAq3yGuTGNz8Jg4Sq1cDT/9cVS3mVl7a/nCArnu79d8y9f9DyZcGc/W1mCAY5To/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c34BiL8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F0FC2BBFC;
	Mon, 24 Jun 2024 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719239726;
	bh=nWmktSg+88kQ1yVIxWO07YeCbZEQqFAeFwKfadIN5NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c34BiL8k8Oc2mfT3KTkZ2QvZ9C7de6z1/RGViSIVCbWwQuc3atXHVyb9aamwU/H7J
	 BpgpEIZBxZzxhuJREjaylp3bUc9/Fq9jSKPJ8q+gQKZlZNSCDveb4ii93xuBZj08g9
	 d17WkoI0JtMVGBMsMMKBMrQGJlQdUgDgAwueqDGFgpTqIq5PYsO0bGyzfmuJewnTXw
	 W5QLAb3RoCnWbI4Mplvkq+Ez5AEibE0xXFlGDLNl1+R2iWb+s8MKBavRmgZasZ8A7h
	 YkWBBWDaDjlaxnYydWV2vh+E8FtWPXpjiJpzEXhVNBmaES5yIsUTAAxijWEJt3StZe
	 Ppc6s11rG2Cyg==
Date: Mon, 24 Jun 2024 08:35:24 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar ADCs
Message-ID: <20240624143524.GA3520322-robh@kernel.org>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
 <20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
 <171865982439.3455065.3692466445202658610.robh@kernel.org>
 <993ef797-51e8-4a57-adf3-1599d9fccba6@baylibre.com>
 <20240618-hexagram-clamp-e716d5bcaa12@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-hexagram-clamp-e716d5bcaa12@spud>

On Tue, Jun 18, 2024 at 07:00:03PM +0100, Conor Dooley wrote:
> On Mon, Jun 17, 2024 at 05:06:29PM -0500, David Lechner wrote:
> > On 6/17/24 4:30 PM, Rob Herring (Arm) wrote:
> > > 
> > > On Mon, 17 Jun 2024 14:53:13 -0500, David Lechner wrote:
> > >> Add device tree bindings for AD4695 and similar ADCs.
> > >>
> > >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> > >> ---
> > >>
> > >> v2 changes:
> > >> * Drop *-wlcsp compatible strings
> > >> * Don't use fallback compatible strings
> > >> * Reword supply descriptions
> > >> * Use standard channel properties instead of adi,pin-pairing
> > >> * Fix unnecessary | character
> > >> * Fix missing blank line
> > >> * Add header file with common mode channel macros
> > >> ---
> > >>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 290 +++++++++++++++++++++
> > >>  MAINTAINERS                                        |  10 +
> > >>  include/dt-bindings/iio/adi,ad4695.h               |   9 +
> > >>  3 files changed, 309 insertions(+)
> > >>
> > > 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml: single-channel: missing type definition
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml: common-mode-channel: missing type definition
> > > 
> > > doc reference errors (make refcheckdocs):
> > > 
> > > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com
> > > 
> > > The base for the series is generally the latest rc1. A different dependency
> > > should be noted in *this* patch.
> > > 
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > > 
> > > pip3 install dtschema --upgrade
> > > 
> > > Please check and re-submit after running the above command yourself. Note
> > > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > > your schema. However, it must be unset to test all examples with your schema.
> > > 
> > 
> > I think the problem is that I don't have a well-known commit as the
> > base-commit in my cover letter (oversight on my part).
> 
> I think for his bot it needs, as written above, to be "in *this* patch".
> I'm not sure if that's to allow for manual review, or something the bot
> does automagically however.

I used to do manual review before sending, but then I added 
co-maintainers that review patches before the bot emails got sent out. 
So now they are sent out as run without review and dependencies aren't 
dealt with at all.

But yes, put something in this patch to say failures are expected 
because of a dependency.

Rob

