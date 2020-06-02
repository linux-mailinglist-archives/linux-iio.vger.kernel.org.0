Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111D61EC28F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 21:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBTRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 15:17:37 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:33841 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgFBTRg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 15:17:36 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.188])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id A77146081342;
        Tue,  2 Jun 2020 21:17:34 +0200 (CEST)
Received: from localhost (34.103.240.103) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 2 Jun 2020
 21:17:34 +0200
Date:   Tue, 2 Jun 2020 21:15:17 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 3/4] iio: chemical: scd30: add serial interface driver
Message-ID: <20200602191517.GE2668@arch>
References: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
 <20200602164723.28858-4-tomasz.duszynski@octakon.com>
 <CAHp75VfjWG_3XC5FJoaU7XXJc+04JTbEKdjZK=g6ffBPvJNhxA@mail.gmail.com>
 <20200602175723.GC2668@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200602175723.GC2668@arch>
X-Originating-IP: [34.103.240.103]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 11947486865640807583
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdefgedruddtfedrvdegtddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvght
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 02, 2020 at 07:57:23PM +0200, Tomasz Duszynski wrote:
> On Tue, Jun 02, 2020 at 08:04:16PM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 2, 2020 at 7:49 PM Tomasz Duszynski
> > <tomasz.duszynski@octakon.com> wrote:
> > >
> > > Add serial interface driver for the SCD30 sensor.
> >
> > ...
> >
> > > +static u16 scd30_serdev_cmd_lookup_tbl[] = {
> > > +       [CMD_START_MEAS] = 0x0036,
> > > +       [CMD_STOP_MEAS] = 0x0037,
> > > +       [CMD_MEAS_INTERVAL] = 0x0025,
> > > +       [CMD_MEAS_READY] = 0x0027,
> > > +       [CMD_READ_MEAS] = 0x0028,
> > > +       [CMD_ASC] = 0x003a,
> > > +       [CMD_FRC] = 0x0039,
> > > +       [CMD_TEMP_OFFSET] = 0x003b,
> > > +       [CMD_FW_VERSION] = 0x0020,
> > > +       [CMD_RESET] = 0x0034,
> >
> > Hmm... Can't we keep them ordered by value?
> >
> > > +};
> >
> > ...
> >
> > > +       ret = wait_for_completion_interruptible_timeout(&priv->meas_ready,
> > > +                                                       SCD30_SERDEV_TIMEOUT);
> > > +       if (ret > 0)
> > > +               ret = 0;
> > > +       else if (!ret)
> > > +               ret = -ETIMEDOUT;
> > > +
> > > +       return ret;
> >
> > Perhaps
> >
> >   if (ret < 0)
> >     return ret;
> >   if (ret == 0)
> >     return -ETIMEDOUT;
> >   return 0;
> >
> > ?
>
> Matter of style but since I will be doing other changes I can touch that
> too.
>
> >
> > ...
> >
> > > +       char txbuf[SCD30_SERDEV_MAX_BUF_SIZE] = { SCD30_SERDEV_ADDR },
> > > +            rxbuf[SCD30_SERDEV_MAX_BUF_SIZE], *rsp = response;
> >
> > Please, apply type to each variable separately.
> >
>
> Fine.
>
> > ...
> >
> > > +       switch (txbuf[1]) {
> > > +       case SCD30_SERDEV_WRITE:
> >
> > > +               if (memcmp(txbuf, txbuf, txsize)) {
> >
> > I'm not sure I understand this.
> >
>
> Ah, thanks for catching this. tx should be compared to rx.
>
> > > +                       dev_err(state->dev, "wrong message received\n");
> > > +                       return -EIO;
> > > +               }
> > > +               break;
> > > +       case SCD30_SERDEV_READ:
> >
> > > +               if (rxbuf[2] != (rxsize -
> > > +                                SCD30_SERDEV_RX_HEADER_SIZE -
> > > +                                SCD30_SERDEV_CRC_SIZE)) {
> >
> > Perhaps you can come up with better indentation/ line split?
> >
>
> I'd rather leave it as is.
>

On the second thought, that would fit 100 column line.

> > > +                       dev_err(state->dev,
> > > +                               "received data size does not match header\n");
> > > +                       return -EIO;
> > > +               }
> > > +
> > > +               rxsize -= SCD30_SERDEV_CRC_SIZE;
> > > +               crc = get_unaligned_le16(rxbuf + rxsize);
> > > +               if (crc != scd30_serdev_calc_crc(rxbuf, rxsize)) {
> > > +                       dev_err(state->dev, "data integrity check failed\n");
> > > +                       return -EIO;
> > > +               }
> > > +
> > > +               rxsize -= SCD30_SERDEV_RX_HEADER_SIZE;
> > > +               memcpy(rsp, rxbuf + SCD30_SERDEV_RX_HEADER_SIZE, rxsize);
> > > +               break;
> > > +       default:
> > > +               dev_err(state->dev, "received unknown op code\n");
> > > +               return -EIO;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> >
> > ...
> >
> > > +static struct serdev_device_driver scd30_serdev_driver = {
> > > +       .driver = {
> >
> > > +               .name = KBUILD_MODNAME,
> >
> > This is not the best what we can do. The name is an ABI and better if
> > it will be constant (independent on file name).
> >
> > > +               .of_match_table = scd30_serdev_of_match,
> > > +               .pm = &scd30_pm_ops,
> > > +       },
> > > +       .probe = scd30_serdev_probe,
> > > +};
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
