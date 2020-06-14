Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114861F890D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgFNNud (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:50:33 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:37171 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbgFNNud (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2020 09:50:33 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.71])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 3AF5262912E8;
        Sun, 14 Jun 2020 15:50:28 +0200 (CEST)
Received: from localhost (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 14 Jun
 2020 15:50:27 +0200
Date:   Sun, 14 Jun 2020 15:48:12 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 0/4] Add support for SCD30 sensor
Message-ID: <20200614134812.GA20800@arch>
References: <20200607175812.95777-1-tomasz.duszynski@octakon.com>
 <20200614141738.0645a954@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200614141738.0645a954@archlinux>
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 3108609642860993618
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiiedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdekledrjedtrddukedtrdduudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 14, 2020 at 02:17:38PM +0100, Jonathan Cameron wrote:
> On Sun, 7 Jun 2020 19:58:08 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Following series adds support for Sensirion SCD30 sensor module capable of
> > measuring carbon dioxide, temperature and relative humidity. CO2 measurements
> > base on NDIR principle while temperature and relative humidity are measured by
> > the on board SHT31. As for sensor communication, both I2C and serial interfaces
> > are supported.
>
> Hi Tomasz,
>
> All looks good to me.
>
> I'll let it sit on the list a bit longer though to give time for anyone
> else to review if they wish and ideally pick up a DT review if
> Rob has time.  It isn't unheard of me to somehow loose a set down
> the back of the sofa, so do poke me if I seem to to have lost this
> in a few weeks time! (I'll try not to of course!)
>

Okay thanks. Will keep an eye on the series.

> Thanks,
>
> Jonathan
>
> >
> > v5:
> > * set pressure calibration via output channel
> > * use kstrtobool() to read value into _enabled attribute
> > * drop explicit parent asignment as the default one is good enough
> >   (seems 'iio: core: pass parent device as parameter during allocation'
> >    series was accepted)
> >
> > v4:
> > * improve formatting
> > * improve error handling readability
> > * fix message validity check on serial write
> >
> > v3:
> > * simplify code by scaling temperature & humidity in _read_meas()
> > * update realbits in scan types
> > * s/adjecent/adjacent
> > * drop IIO_CHAN_INFO_RAW from _write_raw_get_fmt because there's no raw
> >   output channel
> > * rework locking in _read_raw
> > * fix endianess problem on BE machine
> > * align timestamp properly before pushing to buffers
> > * explain why interrupt gets disabled after registration
> > * add trigger validation
> > * drop SCALE for temperature and humidity channel as they are processed
> > * register action which stops measuring after starting measurements
> > * spit generic calibration attr into two doing specific things
> > * add comment explaining why priv in struct scd30_state is for
> > * rename node in binding example to co2-sensor
> >
> > v2:
> > * move asm/byteorder.h towards the bottom of include list
> > * make channel address names in enum more specific
> > * add postfixes to defines and extra comments
> > * drop unneeded i2c include from scd30 header
> > * break generic command sending function into specialized options
> > * expose automatic calibration and forced calibration via the same attr
> > * use SAMP_FREQ to set frequency instead of meas_interval attr
> > * use CALISCALE to set pressure compensation instead of pressure_comp attr
> > * use CALIBBIAS to set temperature offset instead of temp_offset attr
> > * fix order in MAINTAINERS
> > * drop attribute allowing one to reset sensor
> > * as we have dt probing drop board file based probing (i2c_device_id)
> > * merge patches touching related files
> > * use fwnode API to retrieve interrupt from dt
> > * fix interrupt-parent spelling
> > * change binding license
> > * drop supply from required property
> >
> > Tomasz Duszynski (4):
> >   iio: chemical: scd30: add core driver
> >   iio: chemical: scd30: add I2C interface driver
> >   iio: chemical: scd30: add serial interface driver
> >   dt-bindings: iio: scd30: add device binding file
> >
> >  Documentation/ABI/testing/sysfs-bus-iio-scd30 |  34 +
> >  .../iio/chemical/sensirion,scd30.yaml         |  68 ++
> >  MAINTAINERS                                   |   9 +
> >  drivers/iio/chemical/Kconfig                  |  33 +
> >  drivers/iio/chemical/Makefile                 |   3 +
> >  drivers/iio/chemical/scd30.h                  |  78 ++
> >  drivers/iio/chemical/scd30_core.c             | 770 ++++++++++++++++++
> >  drivers/iio/chemical/scd30_i2c.c              | 139 ++++
> >  drivers/iio/chemical/scd30_serial.c           | 263 ++++++
> >  9 files changed, 1397 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> >  create mode 100644 drivers/iio/chemical/scd30.h
> >  create mode 100644 drivers/iio/chemical/scd30_core.c
> >  create mode 100644 drivers/iio/chemical/scd30_i2c.c
> >  create mode 100644 drivers/iio/chemical/scd30_serial.c
> >
> > --
> > 2.27.0
> >
>
