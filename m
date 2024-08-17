Return-Path: <linux-iio+bounces-8518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC595571A
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B041C20B1F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDE1494BF;
	Sat, 17 Aug 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4TdjhBt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796598005B;
	Sat, 17 Aug 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889302; cv=none; b=J6BWTBpTIWeb8jEFTJJRIi5mqVu8mNC+nw3PwUzJCjrj1E1HBvyGqZAojQR/vf1rJKq4vNsSEma51zPdtqRe0/+L70mcpYycVwsO8i2b70+uKyX8JjiH0kNAqqzcXFjh5wMqtCjnOjTQLzO5Cr0T6eGwaLgM0YqGW7OmXzCEObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889302; c=relaxed/simple;
	bh=eWZbiFSANBiGnMWWREKtc2OD3K+I/5bM/NG5nEmc9zE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8M+kNx6N+/RIHNIIfiQ37JiGXOpgITljWnKv6ComF9n15zGNXSf+WoflEGyW9BpRDOmZplM/ce6T6cK3fiKqz7yhStpZ6odXwZvuWmNDRpGpTPf/pwsA99drOJyjU0PZj7AP9E8eRdOEqnmkpnqK7zgXYzey/qDynUassNaCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4TdjhBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71C1C4AF0D;
	Sat, 17 Aug 2024 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723889302;
	bh=eWZbiFSANBiGnMWWREKtc2OD3K+I/5bM/NG5nEmc9zE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4TdjhBtBDzUZBrpzYdyYNMb25cYKGgtQ7nHKsoXC0k11nML9A/nhB1K0P1UiD4H0
	 1+t/mh6ORyjL9ri+mAt20LlIGqWp2BucWXnXP3ShPGB6AXPS3k5aaeLRRpv5O3T6Tv
	 DH0RJltX+GKFlSHntVqMFF+hTpPy9o6+FElI1bZxzb2s72Oup5do4+d7f8AI8irXXC
	 SxxH6+I2ElTId4CSv7Z/oay7gR96jYL8pJOt8343Io1cMC5ZkHVDbD195pqOXdgIJ9
	 uKQKk3Vgi+uAE8hXdR2WPM39cIZD//9y8p3R4V9+umnQS3Pf6lCKzB/LUFpZnFeAm1
	 3KNuDK6ter6Tw==
Date: Sat, 17 Aug 2024 11:08:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: humidity: Add support for ENS210
Message-ID: <20240817110806.72f6b71a@jic23-huawei>
In-Reply-To: <20240805-ens21x-v6-2-5bb576ef26a6@thegoodpenguin.co.uk>
References: <20240805-ens21x-v6-0-5bb576ef26a6@thegoodpenguin.co.uk>
	<20240805-ens21x-v6-2-5bb576ef26a6@thegoodpenguin.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 05 Aug 2024 09:12:53 +0100
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk> wrote:

> Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.
>=20
> The ENS21x is a family of temperature and relative humidity sensors with
> accuracies tailored to the needs of specific applications.
>=20
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>

Hi Joshua,

Sorry for delay on this one, it was next on the list when I ran
out of time before going on a short vacation.

Anyhow, just some minor whitespace stuff so I'll tweak that
whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day etc to poke at it and see if we missed anything.

Also a minor thing with scoped_guard().
Compilers can't figure out that there is not path out of that so
we get an unmarked fallthrough warning.

In file included from ./include/linux/irqflags.h:17,
                 from ./arch/x86/include/asm/special_insns.h:10,
                 from ./arch/x86/include/asm/processor.h:25,
                 from ./include/linux/sched.h:13,
                 from ./include/linux/delay.h:23,
                 from drivers/iio/humidity/ens210.c:18:
drivers/iio/humidity/ens210.c: In function =E2=80=98ens210_read_raw=E2=80=
=99:
./include/linux/cleanup.h:172:9: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
  172 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/iio/humidity/ens210.c:153:17: note: in expansion of macro =E2=80=98=
scoped_guard=E2=80=99
  153 |                 scoped_guard(mutex, &data->lock) {
      |                 ^~~~~~~~~~~~
drivers/iio/humidity/ens210.c:160:9: note: here
  160 |         case IIO_CHAN_INFO_SCALE:
      |         ^~~~
  CHECK   drivers/iio/humidity/ens210.c
  MODPOST Module.symvers

Annoyingly even an unreachable() doesn't work for this particular situation.

 CC [M]  drivers/iio/humidity/ens210.o
drivers/iio/humidity/ens210.o: warning: objtool: ens210_read_raw+0x52: can'=
t find jump dest instruction at .text+0x36c

So for now I've added

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index bc5dedb46b83..e9167574203a 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -157,6 +157,7 @@ static int ens210_read_raw(struct iio_dev *indio_dev,
                                return ret;
                        return IIO_VAL_INT;
                }
+               return -EINVAL; /* compiler warning workaround */
        case IIO_CHAN_INFO_SCALE:
                if (channel->type =3D=3D IIO_TEMP) {
                        *val =3D 15;

Thanks,

Jonathan

> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
> new file mode 100644
> index 000000000000..719fdac817cf
> --- /dev/null
> +++ b/drivers/iio/humidity/ens210.c

> +
> +static int ens210_probe(struct i2c_client *client)
> +{
> +	struct ens210_data *data;
> +	struct iio_dev *indio_dev;
> +	uint16_t part_id;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +					     I2C_FUNC_SMBUS_WRITE_BYTE |
> +					     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
Non standard alignment. I'll fix up.

> +		return dev_err_probe(&client->dev, -EOPNOTSUPP,
> +			"adapter does not support some i2c transactions\n");
> +	}


