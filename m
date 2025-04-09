Return-Path: <linux-iio+bounces-17874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB79A826D0
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5E13AA84A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84AD25FA04;
	Wed,  9 Apr 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq5kOp9D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176B241CAF;
	Wed,  9 Apr 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206944; cv=none; b=MOf1hEHnJcVekefr7WXj+YyFlt6lLd7ZpX/QDaMlGTm+Coi0zBSGWgXDU7kfcfu/occ2cptEvHdaaExg/klW1THl35EJFd9nQ4ixVt/+6MjjiXxI5llEqBF3hu1LtsxuhP91Xy4WXfdbDOHJyGWDtVrSbR7oYTDSX5HDEFtEcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206944; c=relaxed/simple;
	bh=5Mn06X7aAATpKKvIoP8D7Ec4REh2TnHF5WhTc+7j+og=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chZhy3LG9PUT59VsKSrMmjXs/BAE/5bsXGEFqte9AqMxmISf+wOhKyh3iqnIEcFIfB/H3eouDb3SQZDhiHr20CcUBq0J4stgcSfGDDB/rzbOJad3+TRH65FMjyV7AVygiGPHYnQJnW5PZzaFAnJmA5r+2eS41WOGvrbFX1qlbyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq5kOp9D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edb40f357so40631945e9.0;
        Wed, 09 Apr 2025 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744206941; x=1744811741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MQkR8GKZu8tDuYZhwSGSFXNSZlVGTaA7iEBrayVPE/U=;
        b=mq5kOp9D1/gv1SmnzJgwuncPzC7YsnRSKx6G/UQ1RlFdPPW1Cnk1mFB1iCS8zPaKVd
         VvBzi5dtiv03+fd3FRKCx5Dk0gZM+PFtpZV615nUdWC2XCLf0ZEWphabkfWuyKjqdNxX
         jRSR5+fYnh1T9+TIP5fETD321+hU6QJma6GjGCdPQg//9DfOrKHUNM40IOhhK3vbkA8e
         Lw4SG073boQzAv/NecNQmiHw8dws4m7M8sREbpepiJsLMqDNwiOFzmr8nbFBYkFyEaiO
         D4/7aK8wpUmM9s8e6A1nnH9tkKx3NH8SbmvVBl5HYOH/Qo5sy48J692xtaujkTBixkvX
         r7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206941; x=1744811741;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQkR8GKZu8tDuYZhwSGSFXNSZlVGTaA7iEBrayVPE/U=;
        b=Hawbs6o1bxc+gvSmO1GGdewuJfoKZkwsMjxPR1alO/K0p9tblGgwHvOzeAZ6XiIH4a
         PiKiADzqYe09uoBT9GgTPlR4Hc5kFilLpDDNG5lyJvnw3oxtLpBrWGhbhFy9A1u1st8+
         Jt91oeF0kw2mjVqiESQP3N6rUJycEuf3G/4KG7oWy9ROrQzH/nqVK94SkLMy220U//VG
         AaZGv/JtxTztKOyLduP5RIKheKhQEPvtg+txjIAsMWn+OyK4Vs1wMwXtqMsSmDSFXqS6
         fhOeEryxt/semmpO/F6w82DuOt7W/gL6+1JOpzWlvL2ku6xgWWLshXi65Y69PKoKRL75
         DHeg==
X-Forwarded-Encrypted: i=1; AJvYcCWYQJ9TRuWIUqJZL3hk3gWcovAK1ElOEsgzfV8tOEqFK7ALQlmQx/dsLB3+Cpqh9uhKccIga7N10RVd3yEK@vger.kernel.org, AJvYcCWZxz6AfFPg+NcStuPwkdDg6HLpMy6XsMKMr4kTccXIoQFrpaIKdXFNBt/wrYGQfk+Cz49ZWWemeW8=@vger.kernel.org, AJvYcCXa7mgGtWXnJ81bmC0xJlQhNfto9QiOUvdHiMXDgW6libtGFqYR/O1dhV55Jhh5fh9XdEfw9s/vSIpK@vger.kernel.org
X-Gm-Message-State: AOJu0YzlP+2XM9Um8Lhi0OHCSyy2o5ac3kY3gcVIhsHmuLHvVF8jseLf
	rj1QNkr1K7noPa8YA7//Hv4GJ3Wq/RoA6ncILkvq1EvxxB2FtA0z
X-Gm-Gg: ASbGnctonuFQVuunkYt40tCy5ES3Ujy4CS5jpbRPtIn0LEwifaSAhyITutzYKGVKZeB
	G2Bz6UfufoRAoQsm6CF8/SSkPunlPf0sYV1qlcn7cQSwi7QbFdPEwUYchItsvoVQs8Is53O9USf
	nZvu382cRXj2ELffDAzvAoaXvLW/NvUPmUhEern4Av+XD0ERZOLUrZ/zlOVu0lV/iC9lOmrN0DB
	REVJ3zGxru53093RvEp3CFEZf7ou1X330PNMQI4v7sgvlqlDMj3z5cUVmBgz3ZCIwgDx6c2Qdy+
	choJQEV2+xuFtCkdVHt7R6lteepz9p4Yu9TUIK2K23ApHErWMNPZX+gGmpOqZAXoKor/uTzdaH/
	sDLeJREobz02p
X-Google-Smtp-Source: AGHT+IEJyby1yFnF3Ax2EO6Xls/JpywP0iMK9xbRgO0p9NlrHMqeuHEu2VJBl2Fjb9r+lwJfyyBomA==
X-Received: by 2002:a05:6000:1acd:b0:391:1139:2653 with SMTP id ffacd0b85a97d-39d87cdce05mr3011202f8f.52.1744206940769;
        Wed, 09 Apr 2025 06:55:40 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938b7afsm1761191f8f.58.2025.04.09.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:55:40 -0700 (PDT)
Message-ID: <6312a9f30d4ce7f6b6df61597d5b1fb7a614a14b.camel@gmail.com>
Subject: Re: [PATCH v4 5/5] iio: dac: ad3552r-hs: add support for internal
 ramp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Jonathan Cameron	
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Corbet	
 <corbet@lwn.net>, Olivier Moysan <olivier.moysan@foss.st.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 09 Apr 2025 14:55:40 +0100
In-Reply-To: <ldn4jhz7oeo7sxygifra36daydbo3mdsf6dznxbugoixwmn7ci@gok34zr2mund>
References: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
	 <20250408-wip-bl-ad3552r-fixes-v4-5-b33c0264bd78@baylibre.com>
	 <0900650872a1533a344df375e99ce116046b3ee0.camel@gmail.com>
	 <ldn4jhz7oeo7sxygifra36daydbo3mdsf6dznxbugoixwmn7ci@gok34zr2mund>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 11:24 +0200, Angelo Dureghello wrote:
> On 09.04.2025 07:32, Nuno S=C3=A1 wrote:
> > On Tue, 2025-04-08 at 12:18 +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > The ad3552r can be feeded from the HDL controller by an internally
> > > generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> > > to enable or disable it.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
>=20
> Hi Nuno,
> >=20
> > Hi Angelo,
> >=20
> > One issue that needs a respin and then a minor comment... With it,
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > > =C2=A0drivers/iio/dac/ad3552r-hs.c | 166
> > > +++++++++++++++++++++++++++++++++++++++++--
> > > =C2=A01 file changed, 160 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-h=
s.c
> > > index
> > > 37397e188f225a8099745ec03f7c604da76960b1..9a8eed7a06e4f2e7b23d59764b8=
f2fc2
> > > 1e2c4537
> > > 100644
> > > --- a/drivers/iio/dac/ad3552r-hs.c
> > > +++ b/drivers/iio/dac/ad3552r-hs.c
> > > @@ -7,6 +7,7 @@
> > > =C2=A0 */
> > > =C2=A0
> > > =C2=A0#include <linux/bitfield.h>
> > > +#include <linux/debugfs.h>
> > > =C2=A0#include <linux/delay.h>
> > > =C2=A0#include <linux/gpio/consumer.h>
> > > =C2=A0#include <linux/iio/backend.h>
> > > @@ -54,6 +55,18 @@ struct ad3552r_hs_state {
> > > =C2=A0	struct ad3552r_hs_platform_data *data;
> > > =C2=A0	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read
> > > values. */
> > > =C2=A0	u32 config_d;
> > > +	/* Protects backend I/O operations from concurrent accesses. */
> > > +	struct mutex lock;
> > > +};
> > > +
> > > +enum ad3552r_sources {
> > > +	AD3552R_SRC_IIO_BUFFER,
> > > +	AD3552R_SRC_BACKEND_RAMP_GEN,
> > > +};
> > > +
> > > +static const char * const dbgfs_attr_source[] =3D {
> > > +	[AD3552R_SRC_IIO_BUFFER] =3D "iio-buffer",
> > > +	[AD3552R_SRC_BACKEND_RAMP_GEN] =3D "backend-ramp-generator",
> > > =C2=A0};
> >=20
> > nit: I would use more generic strings. I assume "iio-buffer" is just th=
e
> > "normal"
> > data so use something like that. For the ramp, is it 16 bits? I would j=
ust
> > use ex:
> > RAMP_16. I do not thing that the "backend" prefix (as well as "-generat=
or")
> > to add
> > much.
> > > =C2=A0
>=20
> are=20
> "normal", "ramp-16bit"
> ok ?
> Or please let me know the names you prefer.

I'm also not great with naming :). But yes, I think the above is a better c=
hoice

- Nuno S=C3=A1

>=20
> >=20
> > ...
> >=20
> > > +
> > > +static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
> > > +						 char __user *userbuf,
> > > +						 size_t count, loff_t
> > > *ppos)
> > > +{
> > > +	ssize_t len =3D 0;
> > > +	char *buf;
> > > +	int i;
> > > +
> > > +	buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> > > +	if (!buf)
> > > +		return -ENOMEM;
> > > +
> >=20
> > When are we freeing this memory? I also do not see the point for a PAGE=
_SIZE
> > allocation for such a small string table. I would say to simplify thing=
s and
> > use a
> > local buffer with 64/128 bytes (should be more than enough). If you see=
 this
> > growing
> > in the future, you can also go with seq_file.
> >=20
> agh, frogot the free. Sorry.
> Ok, i'll use 128.
> =C2=A0
> > - Nuno S=C3=A1
> >=20
> > > +	for (i =3D 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
> > > +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%s ",
> > > +				 dbgfs_attr_source[i]);
> > > +	}
> > > +	buf[len - 1] =3D '\n';
> > > +
> > > +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> > > +}
> > > +
> > > +static const struct file_operations ad3552r_hs_data_source_fops =3D =
{
> > > +	.owner =3D THIS_MODULE,
> > > +	.write =3D ad3552r_hs_write_data_source,
> > > +	.read =3D ad3552r_hs_show_data_source,
> > > +};
> > > +
> > > +static const struct file_operations ad3552r_hs_data_source_avail_fop=
s =3D {
> > > +	.owner =3D THIS_MODULE,
> > > +	.read =3D ad3552r_hs_show_data_source_avail,
> > > +};
> > > +
> > > =C2=A0static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> > > =C2=A0{
> > > =C2=A0	u16 id;
> > > @@ -550,11 +678,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_st=
ate
> > > *st)
> > > =C2=A0	if (ret)
> > > =C2=A0		return ret;
> > > =C2=A0
> > > -	ret =3D iio_backend_data_source_set(st->back, 0,
> > > IIO_BACKEND_EXTERNAL);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	ret =3D iio_backend_data_source_set(st->back, 1,
> > > IIO_BACKEND_EXTERNAL);
> > > +	ret =3D ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
> > > =C2=A0	if (ret)
> > > =C2=A0		return ret;
> > > =C2=A0
> > > @@ -661,6 +785,26 @@ static const struct iio_info ad3552r_hs_info =3D=
 {
> > > =C2=A0	.debugfs_reg_access =3D &ad3552r_hs_reg_access,
> > > =C2=A0};
> > > =C2=A0
> > > +static void ad3552r_hs_debugfs_init(struct iio_dev *indio_dev)
> > > +{
> > > +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> > > +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> > > +
> > > +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> > > +		return;
> > > +
> > > +	d =3D iio_get_debugfs_dentry(indio_dev);
> > > +	if (!d) {
> > > +		dev_warn(st->dev, "can't set debugfs in driver dir\n");
> > > +		return;
> > > +	}
> > > +
> > > +	debugfs_create_file("data_source", 0600, d, st,
> > > +			=C2=A0=C2=A0=C2=A0 &ad3552r_hs_data_source_fops);
> > > +	debugfs_create_file("data_source_available", 0600, d, st,
> > > +			=C2=A0=C2=A0=C2=A0 &ad3552r_hs_data_source_avail_fops);
> > > +}
> > > +
> > > =C2=A0static int ad3552r_hs_probe(struct platform_device *pdev)
> > > =C2=A0{
> > > =C2=A0	struct ad3552r_hs_state *st;
> > > @@ -705,7 +849,17 @@ static int ad3552r_hs_probe(struct platform_devi=
ce
> > > *pdev)
> > > =C2=A0	if (ret)
> > > =C2=A0		return ret;
> > > =C2=A0
> > > -	return devm_iio_device_register(&pdev->dev, indio_dev);
> > > +	ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D devm_mutex_init(&pdev->dev, &st->lock);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ad3552r_hs_debugfs_init(indio_dev);
> > > +
> > > +	return ret;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0static const struct of_device_id ad3552r_hs_of_id[] =3D {
> > >=20
> >=20

