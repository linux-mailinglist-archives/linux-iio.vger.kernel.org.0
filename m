Return-Path: <linux-iio+bounces-13335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42F9ED4B3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045F618888BB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 18:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037C20371B;
	Wed, 11 Dec 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6DSssme"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247431AF0B4;
	Wed, 11 Dec 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941715; cv=none; b=Fo05+zFDRQ25csKEU4ReAb4vnC/kw/yEdsD0fLt32PH5PTgg/vqesF4A9pxLDOCyDuS3URrVmdF7hieKO+Z0Q/1O21M5HrRNqzxZtX0EM/ueVXflBjNrmBmvkuKbDIEWripkojy12uTp3Dpd/Y8zk6SLFNjGVxTYyGx3pLq3vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941715; c=relaxed/simple;
	bh=JU4/hbf8LqaPk3w9vxQmPNCv7yc8PUm7ADZHQhjLaoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWQ0ij7rm0yOTdL29ZW5xP9STqKgWMJe4hIiY3dL+IQxtxec5l8VXrmfkrNKifhyIZb0O7rKYwRr7fHckoqN4pL6Nd3+AKXDZpL8RBOaoWAM66uYQozU5Nv3Qx9n4KzpNLfdNBXw1sJgdK6J2Z1rBtuu0vBnc81Po/WO4D+q3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6DSssme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8326BC4CED2;
	Wed, 11 Dec 2024 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941713;
	bh=JU4/hbf8LqaPk3w9vxQmPNCv7yc8PUm7ADZHQhjLaoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6DSssmeU18QTcKa3b/Dic7+wNzV8rV/DC3hk6bCBVkkm8BivtQMtxTpw8A7I7DGF
	 6gcMKml4Qqi3Cnaokzt0Ho2AhsoCm3BYlgtA1Y8Ok+YUpsU2Nr60X+wSPA/kILu+zM
	 Y6l2D5+WTimIA09EkRkDknpoI2hW6ruxJ09+9/WHyUKAmCJuIZmfSIt06vbWG/5WM9
	 SAEUSyBrS6ozSe9cp4d6lXrAJ4EJPs5KhjOIpJrh64AD4JYhyK75fC4gBXdwb+wY+K
	 1MFK5FjnAlGttHu/20yM4xPhSYEjylRk1YN2tANQPJcXMxalxlBlwReYNFRk+OKd/v
	 8C1CDXi4SequA==
Date: Wed, 11 Dec 2024 18:28:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <20241211182817.12d63645@jic23-huawei>
In-Reply-To: <CA+4VgcLDQrTcTFjr7MYGtMYpqhzm0gym=zzkt33JGRHFkCXGVg@mail.gmail.com>
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
	<20241203091540.3695650-3-j2anfernee@gmail.com>
	<20241208172236.18441e64@jic23-huawei>
	<CA+4Vgc+veFb6hCP4A7mPH_uiUCnmbsa=guWySRekYj660osQyg@mail.gmail.com>
	<CA+4VgcLDQrTcTFjr7MYGtMYpqhzm0gym=zzkt33JGRHFkCXGVg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 13:47:25 +0800
Yu-Hsian Yang <j2anfernee@gmail.com> wrote:

> Dear Jonathan Cameron,
> 
> Sorry the above mail is not finished and just sent it.
> I would explain why we can't use bulk read sequential bytes in our chips.
Ah! I replied to previous. Let me see what you added.


> > > > +
> > > > +     guard(mutex)(&chip->access_lock);
> > > > +     err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_1, &value);
> > > > +     if (err < 0)
> > > > +             return err;
> > > > +     data[0] = (u8)value;
> > > > +
> > > > +     err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value);
> > > > +     if (err < 0)
> > > > +             return err;  
> > >
> > > Here I think you can use a bulk read as the registers are next to each other.
> > >  
> >  
> Generally, registers with 8 bits support Byte format, and registers
> with more than 8 bits support Word format.
> If transmission a Word command to a register that supports Byte
> format, the second byte will get 0xFF.
> Here, if we use regmap_bulk_read(), we would get first byte correct
> and second byte is wrong 0xff.
> 
> I use i2ctransfer command to demo it.
> root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r1
> 0xff
> root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x14 r1
> 0x0f
> 
> root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r2
> 0xff 0xff
> And if we read four bytes, you can see the first and third byte as we wanted.
> root@evb-npcm845:~# i2ctransfer -f -y 5 w1@0x1d 0x13 r4
> 0xff 0xff 0x0f 0xff
> 
> so we can't use bulk read directly since it would get a second byte 0xff.
> The safe method is to  use read byte twice.
That command does not do the same thing as regmap_bulk_read() will here.
It will issue a series of byte reads.

Jonathan



