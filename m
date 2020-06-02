Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681781EC15E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBRvH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 13:51:07 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:53673 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgFBRvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 13:51:07 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.143.250])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 7A652550CCA6;
        Tue,  2 Jun 2020 19:51:04 +0200 (CEST)
Received: from localhost (34.103.240.103) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 2 Jun 2020
 19:51:03 +0200
Date:   Tue, 2 Jun 2020 19:48:46 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/4] iio: chemical: scd30: add I2C interface driver
Message-ID: <20200602174846.GB2668@arch>
References: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
 <20200602164723.28858-3-tomasz.duszynski@octakon.com>
 <CAHp75Vc60q1PC9j6KR1-OJHxw=nBAHt9zJK=h9f27yJxMHpb8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc60q1PC9j6KR1-OJHxw=nBAHt9zJK=h9f27yJxMHpb8A@mail.gmail.com>
X-Originating-IP: [34.103.240.103]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 10486631732823481503
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtheevtefhffduteejfedtkeeuheejgeejvdetfffgveekffefgeffueeghefgjeenucfkpheptddrtddrtddrtddpfeegrddutdefrddvgedtrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Andy,

On Tue, Jun 02, 2020 at 08:14:13PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 2, 2020 at 7:49 PM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > Add I2C interface driver for the SCD30 sensor.
>
> ...
>
> > +static u16 scd30_i2c_cmd_lookup_tbl[] = {
> > +       [CMD_START_MEAS] = 0x0010,
> > +       [CMD_STOP_MEAS] = 0x0104,
> > +       [CMD_MEAS_INTERVAL] = 0x4600,
> > +       [CMD_MEAS_READY] = 0x0202,
> > +       [CMD_READ_MEAS] = 0x0300,
> > +       [CMD_ASC] = 0x5306,
> > +       [CMD_FRC] = 0x5204,
> > +       [CMD_TEMP_OFFSET] = 0x5403,
> > +       [CMD_FW_VERSION] = 0xd100,
> > +       [CMD_RESET] = 0xd304,
>
> Keep sorted by value?
>

I'd rather leave it as is simply because order here matches order in
sensor datasheet.

> > +};
>
> ...
>
> > +       ret = i2c_master_send(client, txbuf, txsize);
>
> > +       if (ret != txsize)
> > +               return ret < 0 ? ret : -EIO;
>
> Wouldn't be better
>
>   if (ret < 0)
>     return ret;
>   if (ret != txsize)
>     return -EIO;
>
> ?
>

Hmm, okay. Perhaps slightly easier to read.

> > +       if (!rxbuf)
> > +               return 0;
> > +
> > +       ret = i2c_master_recv(client, rxbuf, rxsize);
>
> > +       if (ret != rxsize)
> > +               return ret < 0 ? ret : -EIO;
>
> Ditto.
>
> ...
>
> > +static int scd30_i2c_command(struct scd30_state *state, enum scd30_cmd cmd,
> > +                            u16 arg, void *response, int size)
> > +{
> > +       char crc, buf[SCD30_I2C_MAX_BUF_SIZE], *rsp = response;
> > +       int i, ret;
>
> i -> offset ?
>

'i' is shorter and I am lazy :).

> > +       put_unaligned_be16(scd30_i2c_cmd_lookup_tbl[cmd], buf);
> > +       i = 2;
> > +
> > +       if (rsp) {
> > +               /* each two bytes are followed by a crc8 */
> > +               size += size / 2;
> > +       } else {
> > +               put_unaligned_be16(arg, buf + i);
> > +               crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
> > +               i += 2;
>
> > +               buf[i] = crc;
> > +               i += 1;
>
> buf[offset++] = crc; ?
>

I'd rather stick to what I have now. It looks more consistent.

> > +               /* commands below don't take an argument */
> > +               if ((cmd == CMD_STOP_MEAS) || (cmd == CMD_RESET))
> > +                       i -= 3;
> > +       }
> > +
> > +       ret = scd30_i2c_xfer(state, buf, i, buf, size);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* validate received data and strip off crc bytes */
> > +       for (i = 0; i < size; i += 3) {
> > +               crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
> > +               if (crc != buf[i + 2]) {
> > +                       dev_err(state->dev, "data integrity check failed\n");
> > +                       return -EIO;
> > +               }
> > +
>
> > +               *rsp++ = buf[i];
>
> + 0 (for the sake of consistency?
>

Adding 0 is a little bit odd.

> > +               *rsp++ = buf[i + 1];
> > +       }
> > +
> > +       return 0;
> > +}
>
> ...
>
> > +static struct i2c_driver scd30_i2c_driver = {
> > +       .driver = {
>
> > +               .name = KBUILD_MODNAME,
>
> Better to hard code.
>

I seriously doubt anyone will ever want to change module name. What for?

> > +               .of_match_table = scd30_i2c_of_match,
> > +               .pm = &scd30_pm_ops,
> > +       },
> > +       .probe_new = scd30_i2c_probe,
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
