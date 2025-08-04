Return-Path: <linux-iio+bounces-22242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E28B19A40
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 04:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C28CE4E046C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 02:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63021A44C;
	Mon,  4 Aug 2025 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NchxNRRc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0933993;
	Mon,  4 Aug 2025 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275293; cv=none; b=mMsGghUb7uvJ7YGOhjaoWwwZ5viraXXSnmBj2vCl/A2SZR3B1+T7iWuSZu2R0MByB3dF2TrRpgd30zirwjwG1/1NZDnzUkRvZhBh8LseFaWYhZT/w/ilwuA2eGlK2mO4w50L5o81vy21YWdk0s4s9RRGqvaaaYvjdYqy64SK4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275293; c=relaxed/simple;
	bh=yF31kuPRqpeTTI+pJNKQuGhpe4j7lw9f+kTHTf7sw4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz4W+IKN9xct2JPj0NOFFmIxHlfFn8oreEfVjvPqupQTyklhtL92A/y2fiWsk3UbUxbUvoio9sL1LyOQ5emYW43ICKwz4X1s9uGm9S8yJmGX4uGftTjNyiqV6pC5eo1lBTG8S7RKlF5B0Ux+zro29chHBeYkfeHFuWGG1KedsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NchxNRRc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so4072555a91.0;
        Sun, 03 Aug 2025 19:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754275291; x=1754880091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICf5xJ6xg4MdvVyPWHXWuaEnY6bAabT5btl/udYFsbA=;
        b=NchxNRRc/8naNQGwMR5fZ7jqM9pC7BIel5MBSilLNwRJN9ZQARFE70PZW+R5j1DGYG
         9DWgQLEAqzIUyiVSlo5/J67axfkmIPoqQvZN1/Kc09j1AtS0nGEIC4gTZsz3oo9RDqN/
         M8cJWGbpe5e0KxLogTjukEBHZ4GKXP2Z8EUH3pt8uNnOpmJPD7ThSGSQ4bHdHh3ye4J3
         bgmZURqubfUUG9vgpOfPR+0P/FtTS2vYSBRtVf4HlZLKuNtus2FVBgHLmJpjok4biW7q
         F3+A0rnecamALqz4m6bmhPzqmBHMZJ9FrzXaY92R0SxmRUYm8AfTj5MrPkWinqdxYZGX
         Sziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754275291; x=1754880091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICf5xJ6xg4MdvVyPWHXWuaEnY6bAabT5btl/udYFsbA=;
        b=EZdkCkwS3hDhB770VOtPioBn+P0c5ePQ/Uum7cQpn/7j7R/30gWqjWTJJfobbd8rkZ
         P8BYjsUa4+syVryphmJVGz11X86V+mECQHkWXfle1iB0ryrydeLEDXN2CNoyuly+y4pn
         8VNM+/0udtOUW4zmFFjmeyRh7CPLOBGcdrry3hMwH/Z4H7WuG+31TPL7NIMrFOwB/+dN
         O3tdtFayFHwNyi/V3zvKGlh7Kuq4HtCGOMyoFIcnRyqp32ewLYQVqf67JD0h0IxgiNbD
         okWA0FW25jKUYYOc9gKx5Rrg50G9MePJjQ+R0lStp0S0t9gOtbZ2wM9YFQRLG4S5tRW+
         gAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqRmjpzIV8G7MWEhvw/31n6PDW5rnf1kZU/RpivHXbXVuMz0x+O6sITWUDuwK+abw+tOqHe8sv9/JYyFc9@vger.kernel.org, AJvYcCVoo9z4U8TKj+OWf6hJ89xr4DV5eqTg1Qv/YDvvqe4DMeE1oV7q+y4DcdthNJ3AWHPOQOTkTwI1xVct@vger.kernel.org, AJvYcCWPUqF4ycwE3NiA3AhlLx90YHY7E5PwjFUW+AHXqtK2WqkjOOijC6kuSZzhbKi16yaNvpbWsI5bCLCZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yydmtk0UbXwTmXeHst6EwiJV9M69aD8JxcRcu2APkj/KU4gsOsc
	/ICi13nNkrQTG5BjcPx3gwg8HRgxPJS2RInExRvpPIazUdARVQCQM3vy
X-Gm-Gg: ASbGncvEZPj13TEilFFOw3SWju/cKHy13+oYKGWxiF6x2CtJEPBDFk62vj65H+6Dgkr
	mq6s6fygqWQq/Y+msLsba6N0KUfLl2f8muAyS4VZUG7WK6HIOZ3jygc4PV22djslinjrL9f/Btu
	+NR2u3wa5k+aZHmVgJB62uQTrXk1Li3R56Vo8IHKQbmiBfgrbGfWQh+dJAj65x3rIqNNZHNEQbI
	j46uA8F0VktxJd8YWZx6Jnhg1F4VSTPlJczftV+u4Z+rKwWo2XzSGCVBaYOaj0Aq0Eb6C9VpWjT
	HRc1OsaiFjqtpGJpa9H66CXcdii8WqwybUYdSqmHRwEpGcLb9484viyibhTJO1aC97ldboQORRk
	eWHozs+Zp5utI9FUaC2tWaqg=
X-Google-Smtp-Source: AGHT+IH/t0iEyDzAuGkZpl6GhgCR3HK/exZLgni1IPMsYXJvfTZ+QL9J22CL+JKK+W+pzS9oRBkeKQ==
X-Received: by 2002:a17:90b:4ad2:b0:31e:ff94:3f9d with SMTP id 98e67ed59e1d1-3211631ad9cmr10565824a91.31.1754275290741;
        Sun, 03 Aug 2025 19:41:30 -0700 (PDT)
Received: from dixit ([2401:4900:1c43:eb01:acfe:5fdc:edb4:dbec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc3266sm10338868a91.13.2025.08.03.19.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 19:41:30 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:11:22 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Message-ID: <aJAd0k-PGbQJqD_R@dixit>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <20250802-tlv493d-sensor-v6_16-rc5-v2-2-e867df86ad93@gmail.com>
 <175423802305.483875.12095436762674457962.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175423802305.483875.12095436762674457962.robh@kernel.org>

On Sun, Aug 03, 2025 at 11:20:40AM -0500, Rob Herring (Arm) wrote:
> 
> On Sat, 02 Aug 2025 12:14:28 +0530, Dixit Parmar wrote:
> > Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> > controlled by I2C interface. Main applications includes joysticks, control
> > elements (white goods, multifunction knops), or electric meters (anti-
> > tampering).
> > Drop duplicated entry for infineon,tlv493d from trivial-devices.yaml as
> > its documented in infineon,tlv493d.yaml now.
> > 
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> > ---
> >  .../iio/magnetometer/infineon,tlv493d.yaml         | 45 ++++++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml       |  2 -
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml: vdd: missing type definition
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml: 'example' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> 
Ack.
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250802-tlv493d-sensor-v6_16-rc5-v2-2-e867df86ad93@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
I did not get this fully, is this concerning?
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
Thanks,
Dixit

