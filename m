Return-Path: <linux-iio+bounces-4437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F508AD11C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700F71F232B2
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C7152509;
	Mon, 22 Apr 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWkXu3pe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB11534E2;
	Mon, 22 Apr 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800450; cv=none; b=IuDUA48dWuJht5fer+yZdE7ldl9CfCvMLOMvmuInYcv7wzoAD5th42Ng9KdKmaM/UPAzx02yEvJEAu27P0NnPdhTXPY4yq8fgy4jmc/XEPh/peFph9L6aGwSsDaFkPX057pnYPXjSaYQtdT/Awd5X7o46ZmEiZVoVPs+0jtcpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800450; c=relaxed/simple;
	bh=bDdKoYAB9d9mQ47f7T8q500pdJ/7ql2Phu8MxxLzkpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5FRWExFYpkaDljvSKogqbcwymDMT3kmum78cYZyfT/y7jy006Oq7DlrYR06+/vAVr8jbcClD9Fnmf9V3TbHpb9S1Ake/Z3D8STThvQDw2VTF8Ht5amsFsfHfVMXsJUKwMcpHJy03FO255dkZwES1TZArcOI/tRofmQ0Y0m1B8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWkXu3pe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso3303894f8f.2;
        Mon, 22 Apr 2024 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800447; x=1714405247; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZZ0PLFauS/xD8w/861Ocbo7yL1PKXfpB5Vz/BYqxZY=;
        b=dWkXu3pemvLS5h5s+nhBZNGVTai9X86dl45jU84kZFZRiIBpTKzTRzcKFXmaYBUf8S
         VYM8fqHpryFEBtVhtSSv348nTzLcDG/D17hCjAhfIprkJgzFNp+l33yfVsqvVgoDLG4i
         k/o8yMbjf+nbWhyqgWGOVTPZU4ec4kPYnDNGk2fXQGtltTlZI2E512Q5gwLhC7CgGyQ4
         DzrOBoKFeyR/GnroHshUuyWhU0IQo2yTmACpsKnzVLdNO6/OjgocK5VLHOU6doiaz7/J
         Aej61E/Fk2BjBEHiSG1hys0JVjN1xAfBaFIQMjVAftGAAishNF6+yuwmQ5AZYyRSg4NP
         ndUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800447; x=1714405247;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZZ0PLFauS/xD8w/861Ocbo7yL1PKXfpB5Vz/BYqxZY=;
        b=XzcQBstuZE0VwsiCQdwo2nq1aIcCbxN4lSNsJ3rreHwg9NiG84TtSGLjo+FpTSDhj5
         a1VD4Qd11Jy3O3UrJhQoqxakqf/iTFoubvQ6qvCbZNnm7Od+Hw4Suvsieo8NvO/O0maU
         dRkVAixAvPWTwsKEqyfn/JD3flIiak0elCNuEBIjAkhqURzrgW66bY9xsB/8QWeX/s2t
         BlTBLqV/+9Pzu9hzP0R591I6sz9DRuYrBhhd2G5Tn3i/QK2VFDp1A7s0cfS3fy84Fgve
         pF+QlHgMulVUOq7KcIA+xfQLz7PqKq5k7EyyZl6slsNdsAwBKTnJ33sBjv6KFMHhBx0a
         +dpw==
X-Forwarded-Encrypted: i=1; AJvYcCUOlhuit5XtP1FG0XOcAJLXgeu8jxqaKyHie54ginEglHEzdc81CcdMsT1ro5B6DaU8J3bw7MgH27txe133Q+7igM2COK93mDbhTPEjBFWTkmgsz6TBrmDs2rvKxW7hUkRiWuC1dw==
X-Gm-Message-State: AOJu0Yy8MeLC1jn4szqfdWpSvqyftqR5k7rKZx+ePu5z137bCJJg54oL
	oLGcRaS6NG13Lsg+ALk4iHeRbn24F3YnoT+jbx4zDyHWdFeY6Q+qVPti2Q==
X-Google-Smtp-Source: AGHT+IGDsYjDH7HFIbn+4VgSqEYQyxdzYfUQ7jopUwOv636pZiqz/QWUlFy3bc/kiCK9lj0CoBHSAA==
X-Received: by 2002:adf:f190:0:b0:33e:a5e1:eccc with SMTP id h16-20020adff190000000b0033ea5e1ecccmr6795438wro.68.1713800446234;
        Mon, 22 Apr 2024 08:40:46 -0700 (PDT)
Received: from ?IPv6:2001:a61:3481:2201:6106:96db:d27b:d2c2? ([2001:a61:3481:2201:6106:96db:d27b:d2c2])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6207000000b00346f9071405sm12354207wru.21.2024.04.22.08.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:40:45 -0700 (PDT)
Message-ID: <2131a0feac13fa8c1341c3546761ff1a34ca79df.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: backend: add API for interface tuning
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 22 Apr 2024 17:40:45 +0200
In-Reply-To: <20240420160006.720a3810@jic23-huawei>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	 <20240419-ad9467-new-features-v1-1-3e7628ff6d5e@analog.com>
	 <20240420160006.720a3810@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-20 at 16:00 +0100, Jonathan Cameron wrote:
> On Fri, 19 Apr 2024 17:36:44 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > This is in preparation for supporting interface tuning in one for the
> > devices using the axi-adc backend. The new added interfaces are all
> > needed for that calibration:
>=20
> Would be good to have a little more info in this commit message on what
> interface tuning involves?=C2=A0 I hope a tuning fork and a very good sen=
se

will do

> of hearing...
>=20
> >=20
> > =C2=A0* iio_backend_test_pattern_set();
> > =C2=A0* iio_backend_chan_status();
> > =C2=A0* iio_backend_iodelay_set();
> > =C2=A0* iio_backend_data_sample_trigger().
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Otherwise, trivial stuff inline.=C2=A0 Mostly looks fine.=20
>=20
> I appreciate you pointed out the taps thing was unit free and hence
> possibly controversial.=C2=A0 Not much we can do about it and reality is
> its a tweak factor - things like calibbias are unit free as well
> for exactly the reason that they tend to be incredibly hardware dependent
> and sometimes even instance of hardware dependent.
>=20

Agreed. We could do the iodelays_get() dance but I don't think that would b=
e that
beneficial...

> Jonathan
>=20
> > ---
> > =C2=A0drivers/iio/industrialio-backend.c | 86 +++++++++++++++++++++++++=
+++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 57 +++++++++++++++++++++----
> > =C2=A02 files changed, 136 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index 2fea2bbbe47fd..45eea3b725a35 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -186,6 +186,92 @@ int iio_backend_data_format_set(struct iio_backend=
 *back,
> > unsigned int chan,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_format_set, IIO_BACKEND);
> > =C2=A0
> > +/**
> > + * iio_backend_test_pattern_set - Configure a test pattern
> > + * @back:	Backend device
> > + * @chan:	Channel number
> > + * @pattern:
> > + *
> > + * Configure a test pattern on the backend. This is typically used for
> > + * calibrating the timings on the data digital interface.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_test_pattern_set(struct iio_backend *back,
> > +				 unsigned int chan,
> > +				 enum iio_backend_test_pattern pattern)
> > +{
> > +	if (pattern >=3D IIO_BACKEND_TEST_PATTERN_MAX)
> > +		return -EINVAL;
> > +
> > +	return iio_backend_op_call(back, test_pattern_set, chan, pattern);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_test_pattern_set, IIO_BACKEND);
> > +
> > +/**
> > + * iio_backend_chan_status - Get the channel status
> > + * @back:	Backend device
> > + * @chan:	Channel number
> > + * @status:	Channel status
>=20
> Feels premature to define a structure for status when it simply returns i=
f
> there is an error so far.=C2=A0 Maybe simplify for now, and revisit once =
that
> structure needs to be more complex?

Can do that. No strong feelings :). I'll strip out the boolean and drop the=
 struct.

>=20
> > + *
> > + * Get the current state of the backend channel. Typically used to che=
ck if
> > + * there were any errors sending/receiving data.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_chan_status(struct iio_backend *back, unsigned int cha=
n,
> > +			=C2=A0=C2=A0=C2=A0 struct iio_backend_chan_status *status)
> > +{
> > +	return iio_backend_op_call(back, chan_status, chan, status);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_status, IIO_BACKEND);
> > +
> > +/**
> > + * iio_backend_iodelay_set - Set digital I/O delay
> > + * @back:	Backend device
> > + * @lane:	Lane number
> > + * @tap:	Number of taps
> > + *
> > + * Controls delays on sending/receiving data. One usecase for this is =
to
> > + * calibrate the data digital interface so we get the best results whe=
n
> > + * transferring data. Note that @tap has no unit since the actual dela=
y per tap
> > + * is very backend specific. Hence, frontend devices typically should =
go through
> > + * an array of @taps (the size of that array should typically match th=
e size of
> > + * calibration points on the frontend device) and call this API.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lan=
e,
> > +			=C2=A0=C2=A0=C2=A0 unsigned int tap)
>=20
> taps maybe given it's a number of them?

yeps...

> Is this an industry standard term - sounds like it probably is but my
> google fu is failing.
>=20

Not really (I think). It's very AMD/Xilinx specific. If you google for Xili=
nx IDELAY
control you may found something. I could not find a good name (originally I=
 just had
'delay' but without a proper unit it felt weird), so I admit I used the one=
 it made
more sense for my specific usecase. Open to suggestions though :).

> > +{
> > +	return iio_backend_op_call(back, iodelay_set, lane, tap);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_iodelay_set, IIO_BACKEND);
> > +
> > +/**
> > + * iio_backend_data_sample_trigger - Control when to sample data
> > + * @back:	Backend device
> > + * @trigger:	Data trigger
> > + *
> > + * Mostly useful for input backends. Configures the backend for when t=
o sample
> > + * data (eg: rising vs falling edge).
>=20
> Feels like it might become a flags field at some point, but enum is fine =
for
> trigger for now I guess.
>=20
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_data_sample_trigger(struct iio_backend *back,
> > +				=C2=A0=C2=A0=C2=A0 enum iio_backend_sample_trigger trigger)
> > +{
> > +	if (trigger >=3D IIO_BACKEND_SAMPLE_TRIGGER_MAX)
> > +		return -EINVAL;
> > +
> > +	return iio_backend_op_call(back, data_sample_trigger, trigger);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_data_sample_trigger, IIO_BACKEND);
> > +
> > =C2=A0static void iio_backend_free_buffer(void *arg)
> > =C2=A0{
> > =C2=A0	struct iio_backend_buffer_pair *pair =3D arg;
> > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > index a6d79381866ec..ad793fe0d78c2 100644
> > --- a/include/linux/iio/backend.h
> > +++ b/include/linux/iio/backend.h
> > @@ -15,6 +15,19 @@ enum iio_backend_data_type {
> > =C2=A0	IIO_BACKEND_DATA_TYPE_MAX
> > =C2=A0};
> > =C2=A0
> > +/* vendor specific from 32 */
> > +enum iio_backend_test_pattern {
> > +	/* modified prbs9 */
> > +	IIO_BACKEND_ADI_PRBS_9A =3D 32,
>=20
> Not knowing anything much about this, does it make sense to use an enum,
> or should we face facts that we can't have a true generic interface
> and just use a suitably sized int?
>=20

I'm also not a fan of the above but we do have generic/standard patterns in=
 this core
(and that could be used by others):

- 0x0: pn9a (device specific, modified pn9)
- 0x1: pn23a (device specific, modified pn23)
- 0x4: pn7 (standard O.150)
- 0x5: pn15 (standard O.150)
- 0x6: pn23 (standard O.150)
- 0x7: pn31 (standard O.150)
- 0x9: pnX (device specific, e.g. ad9361)
- 0x0A: Nibble ramp (Device specific e.g. adrv9001)
- 0x0B: 16 bit ramp=20

Lucky enough the user we have for this is only using a custom/modified patt=
ern. my
issue with the int is that how do frontends know what value do they need to=
 pass into
the API? It would really be very backend specific. I know we do expect fron=
tends to
have some assumed knowledge on the backend they're connected too but I woul=
d like to
avoid making those assumptions bigger than they need to be.

My expectation with the enum is that we can have some "contract" between ba=
ckends and
frontends on the pattern to use. I guess we could give it a try (unless you=
 have some
other idea) and if it starts going out of control, I can assume defeat and =
change it
to an int.

Or, is the idea to just have the int parameter and some plain defines in th=
e backend
header?

> How do you unset the test pattern? I expected a IIO_BACKEND_NO_TESTPATERN=
 =3D 0
> or something like that.
>=20

Since this is on the input direction (and for our particular core), we don'=
t have to
unset it. When you choose a test pattern, it just tells the core to match f=
or a
specific signal/pattern. So when you do start getting "real" data, we may s=
till have
those status bits saying there are "errors" but in reality we don't care. W=
e just
care during the tuning/calibration procedure as we configure matching patte=
rs between
frontend and backend...

OTOH for the axi-dac, for example, we do need to unset the test pattern. An=
d we do
that by (re)configuring the internal CW tone or the external data source (t=
ypically
some DMA core).


> > +	IIO_BACKEND_TEST_PATTERN_MAX
> > +};
> > +
> > +enum iio_backend_sample_trigger {
> > +	IIO_BACKEND_SAMPLE_TRIGGER_EDGE_FALLING,
> > +	IIO_BACKEND_SAMPLE_TRIGGER_EDGE_RISING,
> > +	IIO_BACKEND_SAMPLE_TRIGGER_MAX
> > +};
> > +
> > =C2=A0/**
> > =C2=A0 * struct iio_backend_data_fmt - Backend data format
> > =C2=A0 * @type:		Data type.
> > @@ -28,15 +41,27 @@ struct iio_backend_data_fmt {
> > =C2=A0	bool enable;
> > =C2=A0};
> > =C2=A0
> > +/**
> > + * struct iio_backend_chan_status - Backend channel status
> > + *=C2=A0 @errors:	Errors occurred when sending/receiving data.
>=20
> error, it's only a bool so we know there was at least one.

ack

>=20
> > + */
> > +struct iio_backend_chan_status {
> > +	bool errors;
> > +};
> > +
> > =C2=A0/**
> > =C2=A0 * struct iio_backend_ops - operations structure for an iio_backe=
nd
> > - * @enable:		Enable backend.
> > - * @disable:		Disable backend.
> > - * @chan_enable:	Enable one channel.
> > - * @chan_disable:	Disable one channel.
> > - * @data_format_set:	Configure the data format for a specific channel.
> > - * @request_buffer:	Request an IIO buffer.
> > - * @free_buffer:	Free an IIO buffer.
> > + * @enable:			Enable backend.
>=20
> Hmm. I dislike aligning comments because of this sort of noise.
> I guess I can cope without the ideal precursor patch making the padding
> change, but I am moaning about it...

Yeah, I also dislike it in struct members but for some reason I went like t=
his in
here... I'll send a precursor patch in v2.


- Nuno S=C3=A1

