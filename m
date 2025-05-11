Return-Path: <linux-iio+bounces-19439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215FAB295A
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438293B6C40
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FAB25B68D;
	Sun, 11 May 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK9OHVht"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C737464;
	Sun, 11 May 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746977152; cv=none; b=XTbb9giCExTJuiwlJRKUDkvxqJLiu58BCx2Q75Q9gulqDm38m7qqjVG1O03dgiBuZMszkorVpa6xM0/YsV4AcFfkEpbEma6+m5We9okx7FBbbbmRjzJw2XrOLngovcEMO43IhZ8RhY5Tbqnip8tE+OR8e6zln/LbtriiQ1zVwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746977152; c=relaxed/simple;
	bh=NMOSZP82w/0JXMLtKi+E008KsrOyN+F1E/IjsnpTqcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA2IdYwqiaxj+1cTQNRd7Hqp5gDy/bYW5G4Ni4ALJOIuAlxJZwhuWrhVcIkPRUVkG9TEW0yfB9PwKcZDThTMQsYDV9Do20BGM4z/tol1E7z+32D9ma0lkNj1bTRJ5lenJ27eTPv0JvdntZ5djx124T/IOnn/P676Lnt6HaUoWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK9OHVht; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4ddb53a10d1so1297221137.3;
        Sun, 11 May 2025 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746977149; x=1747581949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wtcqqh0bZWYCdN7h46+yA3pFJVsAQ2unB/Qc6851wnc=;
        b=VK9OHVhtlQojPfkKwx/bh4ETgX4bqN9c/TivVqQZ+nUKk7UR2mDBM+CFDz3yOdvNUs
         P3e+uC1DFTfWea9fiy4jIhcL3JFReIihRRT7CVQ5zOiCJOyS/DZnLexgmO0Ps/P/+HhQ
         P5OuMvqBH7Q0EXWtUvDnBoKEFVx7tqCNoNKiwvsgMEaT7SgaypNfaaNzAxXX2H4pbJPF
         Tax8IunCohXVixr9CjBWugt5PCVMrL9uW+KzvKq25STaFy6KPn1sdwNZJ42G1kQUOsTZ
         rMNshm5eJVjV/Bq8a8Iv5iBxabpjirKc2TkC7fburJBy7+JbK/AWqaNjQABvfTWgBaf3
         COfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746977149; x=1747581949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtcqqh0bZWYCdN7h46+yA3pFJVsAQ2unB/Qc6851wnc=;
        b=rSkD+QHj1xBZ7ULG5p8JD394VyjxL1Bx339Ws9te+w13rbutLtreQpGSaxBmvMzbq9
         FVboSHs3wO49kQsj4Nk3B5F52FYQ2hdC1MZ9GYP3R+FS6BRj312roP+bL/XWv8/1+ZXR
         CorBjS3KGXc412ySVPXA8DrkfaLdLwGRxuYfYwqhSEMsrlV0vGmJzVObVPL+hpYCC6c2
         CQPkqq8hiIYa1i6iIC34shMjlztkuGwj+KEmAqqYHdSq+29FF3+S+z8vxvNAo+lHD2Uq
         qnnrUlnf04xAPueD3Ks1f24JG9xH4G3P1+l/eQaIPMIVDhVEqMIympc4940VNCf0gp7G
         9e0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPiFk9yqugKO7oRqtkGDWd6MJWVENe+oxz3JDA2/v1n6J5KFX2TEQIRRffYDw++ZSUjMm7TozB+TiH@vger.kernel.org, AJvYcCVZzeun157K2sg8XuzF1K7eP2c+Ft9nU+4CsAUWxHsE4QclGMLRsOwv9FS7x3vy4T26IjCMvtiRoVTPu9fh@vger.kernel.org, AJvYcCWVWNhlC/4Rlq+qJV0mipCil4furlKd9fF/Ly4B+PmgELlTYRNK01H4guv3yb7N8u1LK+x2fRaabICx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2UjhsOsGAjphXPGHpEQLb41UIG10m4nV2/KGC9Kf3+crDjMlY
	d36TAkyUmXrb/FTjMzyZ0FNdkJIfL5P/5d40RTIpt1Cki+gbc7lUvkuQhVrlC1k=
X-Gm-Gg: ASbGnctaUy+7v7luUdkcJcaP4N5GdsdXGZ+rosAFOktVd0DvKG1AeImv/sFrk+eR1de
	HSNyjaMuBW4xWTv7GQ6Hlrz/fRGd27qoakFni2gwxeJFTJyzwMIY6+AonhMrzDDETncK74TeZAI
	UBRgM+yvi04Oy5KsM89qtHCfh9WEh5RUDxoCvCUTz3aSvpHrENfOIlPVlMkZNHW9/XUU7Ewcga2
	q6Dzbm9aL/p3HkyVggZzKA9wJkqeVgRCdVX6xXC0cIpvCov2fxJUkavBoDzEzmcbA8LCdI8cnxv
	DN9OIswBHNXdCALwXPsS7BzM87ZT3lxI/BEoU4GS1Ua5+ljBYFCI8rBR6FKl
X-Google-Smtp-Source: AGHT+IFwaiGGCVLBdwmWlQrpUaG/zafHNwGA5268jm+7tcyB+/GNoVmO8AlBAJ6MrJxY4/JaS2lrnQ==
X-Received: by 2002:a05:6102:3e16:b0:4de:ed21:4812 with SMTP id ada2fe7eead31-4deed3ef830mr8289938137.22.1746977149303;
        Sun, 11 May 2025 08:25:49 -0700 (PDT)
Received: from localhost ([2804:30c:404b:a800:55e1:4221:1a82:c6cf])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-879f626c5b1sm3796903241.22.2025.05.11.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 08:25:48 -0700 (PDT)
Date: Sun, 11 May 2025 12:27:11 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add AD4170
Message-ID: <aCDBz7iUG7URn3pB@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
 <add7510bd4c9f83011ab949f4fae2c77f57fbc43.1745841276.git.marcelo.schmitt@analog.com>
 <20250509185607.GA3913574-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250509185607.GA3913574-robh@kernel.org>

...
> > +
> > +      adi,reference-select:
> > +        description: |
> > +          Select the reference source to use when converting on the specific
> > +          channel. Valid values are:
> > +          0: Differential reference voltage REFIN+ - REFIN−.
> > +          1: Differential reference voltage REFIN2+ - REFIN2−.
> > +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> > +          3: Analog supply voltage (AVDD) relative AVSS.
> > +          If this field is left empty, the internal reference is selected.
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> 
> You already defined the type in the $defs, so no need to do it again.

The ADC channel node doesn't include/reference the sensor-node.
Wouldn't adi,reference-select default to uint32 if the type is dropped?

The issue here is that adi,reference-select is a property that is meaningful
both for conventional ADC channels and for channels connecting to external
sensors. Thus, the unfortunate repetition of the property. Another possibility
would to be add another type for the ad4170 channels. Something like

$defs:
  ad4170-channel:
    $ref: /schemas/iio/adc/adc.yaml#

      adi,reference-select:
		....

  sensor-node:
    type: object
    $ref: '#/$defs/ad4170-channel'
	...

patternProperties:
  "^channel@[0-9a-f]$":
    $ref: '#/$defs/ad4170-channel'
	...

  "^weighscale@":
    $ref: '#/$defs/sensor-node'
	...

  "^rtd@":
    $ref: '#/$defs/sensor-node'
	...

would that be a better way of having those?

Thanks,
Marcelo

