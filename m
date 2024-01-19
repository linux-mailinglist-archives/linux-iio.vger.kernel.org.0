Return-Path: <linux-iio+bounces-1769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5A832DF5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC4B26E01
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8F55E55;
	Fri, 19 Jan 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRJA8Zpq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65D55C06;
	Fri, 19 Jan 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684556; cv=none; b=t0M9GC+WvVBnyU16w1rIxRzcyJXmKujxsAW2JKiRgG+cpnSlsrSJyJrgOupIKS9hv9WUvcpnAXXHrjwiBWX0Ra+pGgmIURXZ11vNBWXjQJb+dQWtzHyEM4tPl9v/fH30Q1LTzg+k45ZPmfiM/Rm37xQRKAGHY3lBAk/GcoCM9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684556; c=relaxed/simple;
	bh=N34TXSTkzbCMtg7hk3lovR0tSDyxLlLKasghfZeTHsc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=B/kyPBzBcU77JaO5rytx2KM/NBWzJVMQ//wwSvo4SE+Buyy0ULlljwY2W81Gn08NHU66vz8TMOWlqaU7OzEuJKehf9LsJ61KH7pDewaKdMxTegyhDtcQlfGqZkxSjcy01nRSs5N6XVHKGMnesY7Tk4woPNYalmNSflGaMms+M/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRJA8Zpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A27C433C7;
	Fri, 19 Jan 2024 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705684555;
	bh=N34TXSTkzbCMtg7hk3lovR0tSDyxLlLKasghfZeTHsc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NRJA8ZpqA1GLoQ8RGL0OmKjaGIUWJ7LGc96QthpVKKx+q8PRct6WAdGLtf1tVEt28
	 Pd3zkN3V9aFOwufWh/AA8ZdmBMV2NoC2RFQOo+EE8RUHnlqzDWz0cISugLflBY7jHA
	 /9Q+bvOacKxmVpdrxl5KMN/PbtmTycxt1NmkHZ0bYIO8qmRPlgE38c8yDYaRRB8FE/
	 GLAjamxQbFtWWHt+MUK+KLgR6BMRWi+Y04laB5ceFlfuzO01C6WjJ0tCZJ8szIvn4w
	 wgOJmX52cU6jc0FDn4hnAdzhsSWGpaZMC9ufSnMiOZHEGqwTzjmShp2AoyGRSASAk9
	 QddS1THvoMUjA==
Date: Fri, 19 Jan 2024 11:15:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, devicetree@vger.kernel.org
In-Reply-To: <20240119-iio-backend-v6-1-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
 <20240119-iio-backend-v6-1-189536c35a05@analog.com>
Message-Id: <170568455280.599772.1565973986432310014.robh@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: adc: ad9467: add new io-backend
 property


On Fri, 19 Jan 2024 17:00:47 +0100, Nuno Sa wrote:
> The ad9467 will make use of the new IIO backend framework which is a
> provider - consumer interface where IIO backends provide services to
> consumers. As such, and being this device a consumer,  add the new
> generic io-backend property to the bindings.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: io-backends: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240119-iio-backend-v6-1-189536c35a05@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


