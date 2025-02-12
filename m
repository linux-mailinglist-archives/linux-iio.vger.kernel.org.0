Return-Path: <linux-iio+bounces-15444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857BA324F4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA2161D23
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A020ADD8;
	Wed, 12 Feb 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUtBTPbt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884A1F2365;
	Wed, 12 Feb 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359521; cv=none; b=UIafIX2VXu7PXx69kZhAG56zm1mmMOi5qAEV+j+c/n8B6tDbfEOWB8Csc71DjfbB3sHYMT4rqu7f0IM/7bb7uEDPmXTyhH9OAq8bI1pBn9YjyRGMg2gjTEjtPai6i46dEf35bqo/tcjYybmerclx+SltnPdnXdEFi3cmZBNUIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359521; c=relaxed/simple;
	bh=TgoLBoSdsmfmuqpXM5gofGXTPEUeyBBSV93lb6OMC7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgusiZFa3QWIWOPbfFsmlV8vcAER7VtDXup7q+9pgaBMYt3a8KaGhC+Q3licMv+JXaetopFJkj3HDdhCz+SfRzdcBuKHR+WgnoHX5Gad1c4ZiD8OXAJcxlpy0dD39ELlWpPZuAfP6Ts5A6r0O4/WVojBxpOQaxiitZw9eQzdUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUtBTPbt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f62cc4088so81832025ad.3;
        Wed, 12 Feb 2025 03:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739359519; x=1739964319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgoLBoSdsmfmuqpXM5gofGXTPEUeyBBSV93lb6OMC7Y=;
        b=IUtBTPbtTp4ZNtJqA4BWixkMQ5MFlLMWUcYSFL7e31EDCCLw+0PXNgecSsNYF572kE
         vSlQH9uWL/NL32ajvOo9IYeOstxZT4pn655W38HhCZgd9Gq5UGthqUqeos36pgfAYjNT
         NZ8T4lzpQloN/lf6OJmlK4whpB0vw21vF8IE8c253qR82EO4BIcEczsnmRbbfijCNjw8
         Z+MhwW6TNd3qCiKt2zuemY3sgulyJZOaEFlP+Ehy8c6vJlO/CVPsN1RFgthfaf7bokDT
         I/CAVI4JYoCuocisBF0CM4LZgN93IGLGrvugb+hZRjVMtCr3HjdszGY91a7g6nSJ1d9U
         NIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359519; x=1739964319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgoLBoSdsmfmuqpXM5gofGXTPEUeyBBSV93lb6OMC7Y=;
        b=DpiTK9XVBcT6I/LDyjlDBR3CMAeiaQL4xSZrXpww3kxnMmZGSbnCae4S9rWEp4L8TH
         rZIhsmA3qm0xpxVG9dB6Heg3jfxJ0HGJt08PqrRNsmtGp0YnINq4vxGym+SkRUqbiTbE
         k9nH6wbI+WLHtAtA4jC2BB+OF+YC8FEotTtKaOwqdZFDRL2pfiDnQuEBbNrUaVAtMedc
         MP1xCjGixCDKcZ6TGfs1exLy860IKLM2KXsGqRPzG2iWANK6a6mUGsQcqYruI1+9GqSP
         /bOkKDlr+1zOh5b1g/hwGtW+y0RDJgVulfgwq2o82XcR170VygIwoo2qLdW6iJNRqbi+
         T6Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUfHznFPBNsLyhDRpH88qpVKrRxwCICc/ftZHKmEQ1a852YhCkBnyplKTW5W3y62rY+buMP2QBNj2xD@vger.kernel.org, AJvYcCVRXPKKNlC1FA6ZjA8mRpBx0gxGU4JyFvDIMBzcwI4wItXZvNUeB2V+8sYukXHmSb7PU6B1Pm3U@vger.kernel.org, AJvYcCVVU/wgTJ1V+acRbfHijP40zRxC4Te4SPDDmiURuh7LnVvc+cnEo+XS2l8UMn1f0RkthB5JscfRDSd6@vger.kernel.org, AJvYcCVqRZ9WTgJFR1Jy/VTSDjGwGTHHArUKmIW2TveBNUic/7wuJy9CVM8Ytay2wFrYdDpEnbHB0h12JhkToxs=@vger.kernel.org, AJvYcCWvqQd4MJyqcaoRmFECnTkrCrqmkPEUTTjLBFJCIq/u5NwTU466mPEOVTMVUQhrRvxo3AqWyXamTwOB@vger.kernel.org, AJvYcCXCEDxWS0F5hHhaBbrOtxFCiYiyFdOqS8yfmmjZsLCCKhC9G9JsjA853++6GclQhBN3+1A4GVjlV30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLGGHWC1TDKgkMaNX4whlxuutlXKzN0YaaYxiiNHFgpQYB2/W
	ZYTxiZaPBQCsZRuxM5M3iRBmKR8L+VW0yEjwfDxiU+wudLeE2CKh
X-Gm-Gg: ASbGncucLx+5hqYlOeo4wkC4x81MHMVdGKJlXZ0ER3AY++J/LQ6+5vlE3+HsDZ+TW8G
	Ox2mD6MM8QZuavsktlCoCZ/2GnuAfU0zFAS+JtCU+vIAB24CpwXRL5F0zgWW9NBrzCa4LCMy6mq
	+xuGH+couv6dsi/iBlIUTPpwaCG4/hr+Kg12yTg/r2YWv+kayAVj2bTnZRHaBjqA0pZPZD/6J41
	+tyEu5SQJMif5bnKd675CYDil+QYr5qsuU2aVKOjs5CHmKJx0dqj8XRXZHSyFTh74qEJqA+pv4D
	it9gAIW32ZGHFXs=
X-Google-Smtp-Source: AGHT+IGSXAu22CD7MFAjaX8B91j1oDJlyn+2ztCU9HVQMzNMzKgxATJmndOJK7sQ6+CxJ94W1Ao6xg==
X-Received: by 2002:a05:6a21:3987:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1ee5c732ce4mr4676523637.5.1739359518743;
        Wed, 12 Feb 2025 03:25:18 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7308cef0957sm5468012b3a.5.2025.02.12.03.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:25:17 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EF2E541F5559; Wed, 12 Feb 2025 18:25:15 +0700 (WIB)
Date: Wed, 12 Feb 2025 18:25:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Noever <andreas.noever@gmail.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>, Sean Young <sean@mess.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	James Morse <james.morse@arm.com>,
	"Nysal Jan K.A" <nysal@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/9] Extend automarkup support for ABI symbols
Message-ID: <Z6yFG_NntQfkwYli@archie.me>
References: <cover.1739254867.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/8yu6IEGS0ve/RxO"
Content-Disposition: inline
In-Reply-To: <cover.1739254867.git.mchehab+huawei@kernel.org>


--/8yu6IEGS0ve/RxO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 07:22:54AM +0100, Mauro Carvalho Chehab wrote:
> Now that ABI creates a python dictionary, use automarkup to create cross
> references for ABI symbols as well.=20

I get three new warnings:

WARNING: /sys/devices/system/cpu/cpuX/topology/physical_package_id is defin=
ed 2 times: /home/bagas/repo/linux-kernel/Documentation/ABI/stable/sysfs-de=
vices-system-cpu:27; /home/bagas/repo/linux-kernel/Documentation/ABI/testin=
g/sysfs-devices-system-cpu:70
WARNING: /sys/devices/system/cpu/cpuX/topology/ppin is defined 2 times: /ho=
me/bagas/repo/linux-kernel/Documentation/ABI/stable/sysfs-devices-system-cp=
u:89; /home/bagas/repo/linux-kernel/Documentation/ABI/testing/sysfs-devices=
-system-cpu:70
WARNING: Documentation/ABI/testing/sysfs-class-cxl not found

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/8yu6IEGS0ve/RxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6yFGwAKCRD2uYlJVVFO
o8lhAQCQ4fRHrhmP52Ie1GWpvmnThVAVajYhveINLTbggfy+8AEAmFJjGR9fv2Ph
AlybXGGYbN21qaIJUDcQ8kIXnvwi2Q0=
=z6el
-----END PGP SIGNATURE-----

--/8yu6IEGS0ve/RxO--

