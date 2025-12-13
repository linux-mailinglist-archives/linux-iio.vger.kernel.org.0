Return-Path: <linux-iio+bounces-27066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803F1CBB15C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC4A7302D5EC
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF42DA775;
	Sat, 13 Dec 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uraPcWHF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF602D9797;
	Sat, 13 Dec 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765643209; cv=none; b=KMcHp4hW52gw4q46gcDySKJrQ7CjUhzBTx+tQ3bFF9vx75UEPyUyug0QWSi7k1Fe+1e8O1pXGtttM6m5vhdcAeXaQ0/atSLvyJoe3B7Br+BZP+AOsWUxQys9C92+rGi0RwJFYcf2KPvWfxZA9DWcjRmhn3piluAnqZwgyoKrSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765643209; c=relaxed/simple;
	bh=e9qwYAL0L8wF8qznHarPro9XyGerfxKDb+IxkOJORpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hu+8nwpFdciii8xy556G74JNKaBF9Nhehp3uVilAu5jBWCrLA0mPzSDs8BRi9dGQPmgSQ5R0RgTdB8tG7CntbdqSSzx+pqv7TcNIKCRW82sPq5LdOkho8X8Rwx9T4R4TzYa2qMP9yxVfJ8zMXWONT5lBlJGxjObAtsPkqYvjGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uraPcWHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D834EC4CEF7;
	Sat, 13 Dec 2025 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765643207;
	bh=e9qwYAL0L8wF8qznHarPro9XyGerfxKDb+IxkOJORpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uraPcWHFm1Xlw01eGD5aFKulYshdwZz27Gb1goJamdtkHwZ35I21tY6rUzTkfJoY5
	 ZyszzYsMGSjtiD0/QaraYDsSBXEmnB4H+JPmtR/l4xGzVfK950S0uqjo8nCi+K8qO6
	 hA0hVBYVb+YsC8Ih5NMBve3Xd2Pz+z1S33TLnv3VrD9QG2e+u0fN57hGONbK/6owoa
	 ISwXJMuwecIQOCOQEFNl5DcpFWJt0n9GiY0/yEgaqStKbwnUGHkp84HIhm++k9d2eu
	 R995XAwgZ7Z8LUTS++53RqB4HjpoJaTW/YXCt3mBORobCKg+kgk2lcNkGLcPB8w+0U
	 KDJYkhzdFZadg==
Date: Sat, 13 Dec 2025 16:26:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Message-ID: <20251213162637.678b2b82@jic23-huawei>
In-Reply-To: <CY4PR03MB3399DB00FCF85E28132833199BAEA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
	<20251205144058.1918-3-antoniu.miclaus@analog.com>
	<20251206190332.53874d41@jic23-huawei>
	<CY4PR03MB3399DB00FCF85E28132833199BAEA@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 10:41:07 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> Hi,
> > 
> > Could do this as something like:
> > 
> > 	st->gain_configs[i++] = (struct adl8113_gain_config) {
> > 		.path = ADL8113_INTERNAL_AMP,
> > 		.gain_db = 14,
> > 	};
> > 
> > 	st->gain_configs[i++] = (struct adl8113_gain_config) {
> > 		.path = ADL8113_INTERNAL_BYPASS,
> > 		.gain_db = -2,
> > 	};
> > 
> > etc.
> >   
> > > +	i++;
> > > +
> > > +	/* Always include internal bypass (-2dB insertion loss) */
> > > +	st->gain_configs[i].path = ADL8113_INTERNAL_BYPASS;
> > > +	st->gain_configs[i].gain_db = -2;
> > > +	i++;
> > > +
> > > +	/* Add external bypass A if configured */
> > > +	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
> > > +				      &external_a_gain)) {
> > > +		st->gain_configs[i].path = ADL8113_EXTERNAL_A;
> > > +		st->gain_configs[i].gain_db = external_a_gain;
> > > +		i++;
> > > +	}
> > > +
> > > +	/* Add external bypass B if configured */
> > > +	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
> > > +				      &external_b_gain)) {
> > > +		st->gain_configs[i].path = ADL8113_EXTERNAL_B;
> > > +		st->gain_configs[i].gain_db = external_b_gain;
> > > +		i++;
> > > +	}
> > > +
> > > +	/*
> > > +	 * If there's a free external bypass path, add one with INT_MIN gain
> > > +	 * to represent "nothing connected" for testing purposes  
> > 
> > I don't follow this one.  What sort of testing purpose?  Something we want
> > in a real system?  
> This addition was suggested by David in v4. But I can revert it in the next series.
Ok. I looked back and found it.  I don't mind this feature with
more explanation.  However, I'm not sure it's actually useful other than for
replicating figure 121 on the datasheet which I can't really see as particularly
useful for testing.  Mind you I've no real idea how these are used :)

Jonathan

> 
> Regards,
> Antoniu


