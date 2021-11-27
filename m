Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5A460012
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355453AbhK0QM4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 11:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355498AbhK0QKz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 11:10:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B8C061758;
        Sat, 27 Nov 2021 08:07:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BB6FB80019;
        Sat, 27 Nov 2021 16:07:39 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 3DCDFC53FAD;
        Sat, 27 Nov 2021 16:07:34 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:12:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iio: expose shared parameter in IIO_ENUM_AVAILABLE
Message-ID: <20211127161236.08a64fff@jic23-huawei>
In-Reply-To: <CA+U=DspLLJcd8Mvkeb7iAEgsxvmpwaEay1Ur-Rq6M=8YKcosRQ@mail.gmail.com>
References: <20211119085627.6348-1-antoniu.miclaus@analog.com>
        <CA+U=DspLLJcd8Mvkeb7iAEgsxvmpwaEay1Ur-Rq6M=8YKcosRQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Nov 2021 12:46:58 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Nov 19, 2021 at 11:37 AM Antoniu Miclaus
> <antoniu.miclaus@analog.com> wrote:
> >
> > The shared parameter should be configurable based on its usage, and not
> > constrained to IIO_SHARED_BY_TYPE.
> >
> > This patch aims to improve the flexibility in using the
> > IIO_ENUM_AVAILABLE define and avoid redefining custom iio enums that
> > expose the shared parameter.
> >
> > An example is the ad5766.c driver where IIO_ENUM_AVAILABLE_SHARED was
> > defined in order to achieve `shared` parameter customization.
> >
> > The current state of the IIO_ENUM_AVAILABLE implementation will imply
> > similar redefinitions each time a driver will require access to the
> > `shared` parameter. An example would be admv1013 driver which will
> > require custom device attribute for the frequency translation modes:
> > Quadrature I/Q mode and Intermediate Frequency mode.
> >  
> 
> This time, I also got a chance to look at this :)
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Applied, thanks

> 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v2:
> >  - wrap line to 80 chars
> >  - fix wrong macro update
> >  drivers/iio/accel/bma180.c                |  2 +-
> >  drivers/iio/accel/mma9553.c               |  2 +-
> >  drivers/iio/adc/ad7192.c                  |  3 ++-
> >  drivers/iio/adc/hi8435.c                  |  2 +-
> >  drivers/iio/dac/ad5064.c                  |  4 ++--
> >  drivers/iio/dac/ad5380.c                  |  2 +-
> >  drivers/iio/dac/ad5446.c                  |  2 +-
> >  drivers/iio/dac/ad5504.c                  |  2 +-
> >  drivers/iio/dac/ad5624r_spi.c             |  2 +-
> >  drivers/iio/dac/ad5686.c                  |  2 +-
> >  drivers/iio/dac/ad5766.c                  | 13 ++-----------
> >  drivers/iio/dac/ad5791.c                  |  2 +-
> >  drivers/iio/dac/max5821.c                 |  2 +-
> >  drivers/iio/dac/mcp4725.c                 |  8 ++++----
> >  drivers/iio/dac/stm32-dac.c               |  2 +-
> >  drivers/iio/dac/ti-dac082s085.c           |  2 +-
> >  drivers/iio/dac/ti-dac5571.c              |  2 +-
> >  drivers/iio/dac/ti-dac7311.c              |  2 +-
> >  drivers/iio/magnetometer/hmc5843_core.c   |  4 ++--
> >  drivers/iio/trigger/stm32-timer-trigger.c |  4 ++--
> >  include/linux/iio/iio.h                   |  5 +++--
> >  21 files changed, 31 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index 2edfcb4819b7..09496f358ad9 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -658,7 +658,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
> >
> >  static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
> >         IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
> > -       IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
> > +       IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
> >         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
> >         { }
> >  };
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index ba3ecb3b57dc..0570ab1cc064 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -917,7 +917,7 @@ static const struct iio_enum mma9553_calibgender_enum = {
> >
> >  static const struct iio_chan_spec_ext_info mma9553_ext_info[] = {
> >         IIO_ENUM("calibgender", IIO_SHARED_BY_TYPE, &mma9553_calibgender_enum),
> > -       IIO_ENUM_AVAILABLE("calibgender", &mma9553_calibgender_enum),
> > +       IIO_ENUM_AVAILABLE("calibgender", IIO_SHARED_BY_TYPE, &mma9553_calibgender_enum),
> >         {},
> >  };
> >
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 2121a812b0c3..cc990205f306 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -257,7 +257,8 @@ static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
> >         },
> >         IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
> >                  &ad7192_syscalib_mode_enum),
> > -       IIO_ENUM_AVAILABLE("sys_calibration_mode", &ad7192_syscalib_mode_enum),
> > +       IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
> > +                          &ad7192_syscalib_mode_enum),
> >         {}
> >  };
> >
> > diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> > index 8b353e26668e..e665e14c6e54 100644
> > --- a/drivers/iio/adc/hi8435.c
> > +++ b/drivers/iio/adc/hi8435.c
> > @@ -350,7 +350,7 @@ static const struct iio_enum hi8435_sensing_mode = {
> >
> >  static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
> >         IIO_ENUM("sensing_mode", IIO_SEPARATE, &hi8435_sensing_mode),
> > -       IIO_ENUM_AVAILABLE("sensing_mode", &hi8435_sensing_mode),
> > +       IIO_ENUM_AVAILABLE("sensing_mode", IIO_SHARED_BY_TYPE, &hi8435_sensing_mode),
> >         {},
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> > index fd9cac4f6321..27ee2c63c5d4 100644
> > --- a/drivers/iio/dac/ad5064.c
> > +++ b/drivers/iio/dac/ad5064.c
> > @@ -377,7 +377,7 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
> >                 .shared = IIO_SEPARATE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5064_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ad5064_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5064_powerdown_mode_enum),
> >         { },
> >  };
> >
> > @@ -389,7 +389,7 @@ static const struct iio_chan_spec_ext_info ltc2617_ext_info[] = {
> >                 .shared = IIO_SEPARATE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ltc2617_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ltc2617_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ltc2617_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> > index 8ca26bb4b62f..e38860a6a9f3 100644
> > --- a/drivers/iio/dac/ad5380.c
> > +++ b/drivers/iio/dac/ad5380.c
> > @@ -249,7 +249,7 @@ static const struct iio_chan_spec_ext_info ad5380_ext_info[] = {
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
> >                  &ad5380_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ad5380_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5380_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> > index 3cc5513a6cbf..1c9b54c012a7 100644
> > --- a/drivers/iio/dac/ad5446.c
> > +++ b/drivers/iio/dac/ad5446.c
> > @@ -142,7 +142,7 @@ static const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
> >                 .shared = IIO_SEPARATE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5446_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ad5446_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5446_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> > index 19cdf9890d02..b631261efa97 100644
> > --- a/drivers/iio/dac/ad5504.c
> > +++ b/drivers/iio/dac/ad5504.c
> > @@ -241,7 +241,7 @@ static const struct iio_chan_spec_ext_info ad5504_ext_info[] = {
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
> >                  &ad5504_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ad5504_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5504_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
> > index 530529feebb5..3c98941b9f99 100644
> > --- a/drivers/iio/dac/ad5624r_spi.c
> > +++ b/drivers/iio/dac/ad5624r_spi.c
> > @@ -159,7 +159,7 @@ static const struct iio_chan_spec_ext_info ad5624r_ext_info[] = {
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
> >                  &ad5624r_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ad5624r_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5624r_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > index 8f001db775f4..e592a995f404 100644
> > --- a/drivers/iio/dac/ad5686.c
> > +++ b/drivers/iio/dac/ad5686.c
> > @@ -184,7 +184,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
> >                 .shared = IIO_SEPARATE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5686_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ad5686_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5686_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> > index b0d220c3a126..43189af2fb1f 100644
> > --- a/drivers/iio/dac/ad5766.c
> > +++ b/drivers/iio/dac/ad5766.c
> > @@ -426,14 +426,6 @@ static ssize_t ad5766_write_ext(struct iio_dev *indio_dev,
> >         .shared = _shared, \
> >  }
> >
> > -#define IIO_ENUM_AVAILABLE_SHARED(_name, _shared, _e) \
> > -{ \
> > -       .name = (_name "_available"), \
> > -       .shared = _shared, \
> > -       .read = iio_enum_available_read, \
> > -       .private = (uintptr_t)(_e), \
> > -}
> > -
> >  static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
> >
> >         _AD5766_CHAN_EXT_INFO("dither_enable", AD5766_DITHER_ENABLE,
> > @@ -443,9 +435,8 @@ static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
> >         _AD5766_CHAN_EXT_INFO("dither_source", AD5766_DITHER_SOURCE,
> >                               IIO_SEPARATE),
> >         IIO_ENUM("dither_scale", IIO_SEPARATE, &ad5766_dither_scale_enum),
> > -       IIO_ENUM_AVAILABLE_SHARED("dither_scale",
> > -                                 IIO_SEPARATE,
> > -                                 &ad5766_dither_scale_enum),
> > +       IIO_ENUM_AVAILABLE("dither_scale", IIO_SEPARATE,
> > +                          &ad5766_dither_scale_enum),
> >         {}
> >  };
> >
> > diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> > index a0923b76e8b6..7b4579d73d18 100644
> > --- a/drivers/iio/dac/ad5791.c
> > +++ b/drivers/iio/dac/ad5791.c
> > @@ -285,7 +285,7 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
> >                  &ad5791_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ad5791_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5791_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> > index 7da4710a6408..fce640b7f1c8 100644
> > --- a/drivers/iio/dac/max5821.c
> > +++ b/drivers/iio/dac/max5821.c
> > @@ -137,7 +137,7 @@ static const struct iio_chan_spec_ext_info max5821_ext_info[] = {
> >                 .shared = IIO_SEPARATE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE, &max5821_powerdown_mode_enum),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &max5821_powerdown_mode_enum),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &max5821_powerdown_mode_enum),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> > index 34b14aafb630..98b2c2f10bf3 100644
> > --- a/drivers/iio/dac/mcp4725.c
> > +++ b/drivers/iio/dac/mcp4725.c
> > @@ -221,8 +221,8 @@ static const struct iio_chan_spec_ext_info mcp4725_ext_info[] = {
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE,
> >                         &mcp472x_powerdown_mode_enum[MCP4725]),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode",
> > -                       &mcp472x_powerdown_mode_enum[MCP4725]),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> > +                          &mcp472x_powerdown_mode_enum[MCP4725]),
> >         { },
> >  };
> >
> > @@ -235,8 +235,8 @@ static const struct iio_chan_spec_ext_info mcp4726_ext_info[] = {
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE,
> >                         &mcp472x_powerdown_mode_enum[MCP4726]),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode",
> > -                       &mcp472x_powerdown_mode_enum[MCP4726]),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> > +                          &mcp472x_powerdown_mode_enum[MCP4726]),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> > index dd2e306824e7..cd71cc4553a7 100644
> > --- a/drivers/iio/dac/stm32-dac.c
> > +++ b/drivers/iio/dac/stm32-dac.c
> > @@ -246,7 +246,7 @@ static const struct iio_chan_spec_ext_info stm32_dac_ext_info[] = {
> >                 .shared = IIO_SEPARATE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE, &stm32_dac_powerdown_mode_en),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &stm32_dac_powerdown_mode_en),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &stm32_dac_powerdown_mode_en),
> >         {},
> >  };
> >
> > diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
> > index 5c14bfb16521..6beda2193683 100644
> > --- a/drivers/iio/dac/ti-dac082s085.c
> > +++ b/drivers/iio/dac/ti-dac082s085.c
> > @@ -160,7 +160,7 @@ static const struct iio_chan_spec_ext_info ti_dac_ext_info[] = {
> >                 .shared    = IIO_SHARED_BY_TYPE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ti_dac_powerdown_mode),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> > index 546a4cf6c5ef..4a3b8d875518 100644
> > --- a/drivers/iio/dac/ti-dac5571.c
> > +++ b/drivers/iio/dac/ti-dac5571.c
> > @@ -212,7 +212,7 @@ static const struct iio_chan_spec_ext_info dac5571_ext_info[] = {
> >                 .shared    = IIO_SEPARATE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SEPARATE, &dac5571_powerdown_mode),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &dac5571_powerdown_mode),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &dac5571_powerdown_mode),
> >         {},
> >  };
> >
> > diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
> > index 09218c3029f0..99f275829ec2 100644
> > --- a/drivers/iio/dac/ti-dac7311.c
> > +++ b/drivers/iio/dac/ti-dac7311.c
> > @@ -146,7 +146,7 @@ static const struct iio_chan_spec_ext_info ti_dac_ext_info[] = {
> >                 .shared    = IIO_SHARED_BY_TYPE,
> >         },
> >         IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
> > -       IIO_ENUM_AVAILABLE("powerdown_mode", &ti_dac_powerdown_mode),
> > +       IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
> >         { },
> >  };
> >
> > diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> > index f08726bf5ec3..5a730d9bdbb0 100644
> > --- a/drivers/iio/magnetometer/hmc5843_core.c
> > +++ b/drivers/iio/magnetometer/hmc5843_core.c
> > @@ -246,7 +246,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
> >
> >  static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
> >         IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
> > -       IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
> > +       IIO_ENUM_AVAILABLE("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
> >         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> >         { }
> >  };
> > @@ -260,7 +260,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
> >
> >  static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
> >         IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
> > -       IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
> > +       IIO_ENUM_AVAILABLE("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
> >         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> >         { }
> >  };
> > diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> > index 33083877cd19..02b87b0f9d70 100644
> > --- a/drivers/iio/trigger/stm32-timer-trigger.c
> > +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> > @@ -696,9 +696,9 @@ static const struct iio_chan_spec_ext_info stm32_trigger_count_info[] = {
> >                 .write = stm32_count_set_preset
> >         },
> >         IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
> > -       IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
> > +       IIO_ENUM_AVAILABLE("enable_mode", IIO_SHARED_BY_TYPE, &stm32_enable_mode_enum),
> >         IIO_ENUM("trigger_mode", IIO_SEPARATE, &stm32_trigger_mode_enum),
> > -       IIO_ENUM_AVAILABLE("trigger_mode", &stm32_trigger_mode_enum),
> > +       IIO_ENUM_AVAILABLE("trigger_mode", IIO_SHARED_BY_TYPE, &stm32_trigger_mode_enum),
> >         {}
> >  };
> >
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 324561b7a5e8..07025d6b3de1 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -103,15 +103,16 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
> >  /**
> >   * IIO_ENUM_AVAILABLE() - Initialize enum available extended channel attribute
> >   * @_name:     Attribute name ("_available" will be appended to the name)
> > + * @_shared:   Whether the attribute is shared between all channels
> >   * @_e:                Pointer to an iio_enum struct
> >   *
> >   * Creates a read only attribute which lists all the available enum items in a
> >   * space separated list. This should usually be used together with IIO_ENUM()
> >   */
> > -#define IIO_ENUM_AVAILABLE(_name, _e) \
> > +#define IIO_ENUM_AVAILABLE(_name, _shared, _e) \
> >  { \
> >         .name = (_name "_available"), \
> > -       .shared = IIO_SHARED_BY_TYPE, \
> > +       .shared = _shared, \
> >         .read = iio_enum_available_read, \
> >         .private = (uintptr_t)(_e), \
> >  }
> > --
> > 2.34.0
> >  

