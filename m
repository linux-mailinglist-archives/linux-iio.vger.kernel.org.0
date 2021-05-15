Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A3381680
	for <lists+linux-iio@lfdr.de>; Sat, 15 May 2021 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhEOHQw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 May 2021 03:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhEOHQt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 May 2021 03:16:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60412C06174A;
        Sat, 15 May 2021 00:15:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so979762edt.13;
        Sat, 15 May 2021 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Hn1lJQY6S+IEmG30ufHy3LNGIX4J8A57IxQPe1RzWM=;
        b=DvDnzW7Bn9kCt9i95MQqRBmIyVHaWp6KE370ZuxYNdC4V8Ryw4c0yZsFLuj4bovuyo
         7gLkTjLT+p0Y8HZfvlxPi0LOhNMOyaEadwEoHS1lF1J60zHuLO9zT2+nyUETc+AprkYu
         9qdEMgbE9w+ESpCtgR0GJ5HCeK7aWUKnJm2jQzbzvPtQmoPbabM64Z4nNTogflGvRKHv
         ATiRGwO4KVnLXcmAQUWStyDbIGcGA++xVuRlJ3BZ4ZjO6aXSAD59qEhzAeXggUgWHh/R
         6PnaWAnf1S9T2a2Tt/mEyG0W9jrrv6KXyaVmMrdwEdRTxd7V5weYRtlWsFS9xIMsYaLA
         Gu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Hn1lJQY6S+IEmG30ufHy3LNGIX4J8A57IxQPe1RzWM=;
        b=LLUPU/Fdrf9XrVrS6S5ZEZDtu/R8WGis2dcQS/QnUvbeUKYbnNu6j7ux+2DV0HvLOj
         Mav8L7qEqJtLbQKJ7D3sqlGmM1aCsgHjUnjebXiBtkUkwwST2bp0H9WXSd8169J8Zc1t
         4GCr8/eImqQbxJ/Sn+/qfF+HbwIZNHrn6cONmAPaoLTHANoXFdSohUbAGI3rI4G06yMq
         rTKfPQxFUeA0CVyLyp74Xv28tXr7zj34ZjfDxA7xly+NFW5wbsHDkg8xuFxUfZl6AOk0
         ctaMI3XY11iLBg+S5p0y862nUC1U6PibdIQG+ZXa4PYAPoTAbpFLm7yV86UPjw4fxbbj
         6t5g==
X-Gm-Message-State: AOAM532lzKBAWU24vNJ/5K1+HzzJsQCGYsFxf3zrncX4HUsaleHjgxKK
        XXzMTj3cVdFJJ/kv4rEaJczwTbL6p7hWUq9xGTI=
X-Google-Smtp-Source: ABdhPJyU3+jpm++/knbeTStCH0O2RytKeOf5FyNMhj5Px5Os7fPqbd7Qi8+53wwIHb9RAwsgy1pC8UUGGDPuqci/rgc=
X-Received: by 2002:aa7:d282:: with SMTP id w2mr3496237edq.45.1621062931825;
 Sat, 15 May 2021 00:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <a50bce9fd6d28fa2aa0171ba406da0dd6714fcc3.1620926923.git.info@ministro.hu>
 <CA+U=DsrBcY0nameycswS9xdpQ3ziQSLnDZrpih76VcPz+qV4QQ@mail.gmail.com> <20210514140928.GA14139@dev>
In-Reply-To: <20210514140928.GA14139@dev>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 15 May 2021 10:15:16 +0300
Message-ID: <CA+U=DspzmwXBRnkZYea+JHqwRbCAF-C_87DBTA6Mq0zGSLpJhA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: adc: driver for texas instruments ads7142
To:     =?UTF-8?B?SsOzenNlZiBIb3J2w6F0aA==?= <info@ministro.hu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 14, 2021 at 5:10 PM J=C3=B3zsef Horv=C3=A1th <info@ministro.hu>=
 wrote:
>
> Hi Alexandru,
>
> On Fri, May 14, 2021 at 11:50:00AM +0300, Alexandru Ardelean wrote:
> > On Fri, May 14, 2021 at 1:52 AM Jozsef Horvath <info@ministro.hu> wrote=
:
> > >
> > > This is an iio driver for
> > >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> > >
> >
> > Hey,
> >
> > Looks good overall.
> > Some comments inline.
> >
> > > All of the data buffer modes, supported by the device are selectable
> > >  over sysfs:
> > >   /sys/bus/iio/devices/iio:deviceX/buffer_mode
> > >
> > > Data buffer operation modes:
> > >   - start_burst:
> > >     In triggered buffer preenable hook: not relevant.
> > >     In trigger handler: the driver selects the autonomous monitoring
> > >       (see chapter 7.4.3 in datasheet) operation mode,
> > >           configures the channels in sequencer as specified by
> > >       sysfs(scan_elements/in_voltageY_en),
> > >           sets the data buffer mode to "Start Burst Mode",
> > >       then starts the conversion.
> > >     In irq handler: the driver pushes the conversion results received
> > >       from the device to the buffer,
> > >       then restarts the conversion like in trigger handler.
> > >     Both IRQ and trigger are required to support this mode.
> > >     See chapter 7.4.3.2.1 "Autonomous Mode with Start Burst"
> > >     in datasheet.
> > >   - stop_burst:
> > >     In triggered buffer preenable hook: the driver selects the
> > >       autonomous monitoring (see chapter 7.4.3 in datasheet)
> > >       operation mode,
> > >       configures the channels in sequencer as
> > >       specified by sysfs(scan_elements/in_voltageY_en),
> > >           sets the data buffer mode to "Stop Burst Mode",
> > >       then starts the conversion.
> > >     In trigger handler: the driver pushes the conversion results rece=
ived
> > >       from the device to the buffer,
> > >           then restarts the conversion like in preenable hook.
> > >     In irq handler: not relevant.
> > >     Trigger is required to support this mode.
> > >     See chapter 7.4.3.2.2 "Autonomous Mode with Stop Burst"
> > >     in datasheet.
> > >   - pre_alert:
> > >     In triggered buffer preenable hook: the driver selects the autono=
mous
> > >       monitoring (see chapter 7.4.3 in datasheet) operation mode,
> > >       configures the channels in sequencer
> > >         as specified by sysfs(scan_elements/in_voltageY_en),
> > >       configures the digital window comparator and alert flags,
> > >           sets the data buffer mode to "Pre Alert Data Mode",
> > >       then starts the conversion.
> > >     In trigger handler: not relevant.
> > >     In irq handler: the driver pushes the conversion results received
> > >       from the device to the buffer,
> > >       then restarts the conversion like in preenable hook.
> > >     IRQ is required to support this mode.
> > >     See chapter 7.4.3.1.1 "Autonomous Mode with Pre Alert Data"
> > >     in datasheet
> > >   - post_alert:
> > >     The operations are same like in pre_alert mode,
> > >       except the data buffer mode selection, the selected mode is
> > >       "Post Alert Data Mode".
> > >     See chapter 7.4.3.1.2 "Autonomous Mode with Post Alert Data"
> > >     in datasheet
> > >
> > > The in_voltageY_raw can be used, if the buffering mode is not enabled
> > >  in sysfs(buffer/enable).
> > >  The driver initiates a single conversion in the device for each
> > >  read request(in_voltageY_raw).
> > >  This is a one-shot conversion.
> > >  See chapter 7.4.2.2 "Manual Mode with AUTO Sequence" in datasheet.
> > >
> > > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > >
> > > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> > > ---
> > >
> > > changes v1
> > >   - All of the buffer opertaion modes
> > >     (pre_alert, post_alert, start_burst, stop_burst)
> > >         are added
> > >   - Added triggered buffer
> > >   - Added buffer operation mode selection sysfs support
> > >   - Redundant parameters (ti,threshold-rising, etc.)
> > >     are removed
> > >   - Supply name changed(vref -> avdd)
> > >   - Added dvdd supply
> > >   - Added device sampling rate calculation
> > >   - Use device-managed functions for regulator, iio device register
> > >     and triggered buffer
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-adc-ti-ads7142  |   11 +
> > >  MAINTAINERS                                   |    7 +
> > >  drivers/iio/adc/Kconfig                       |   13 +
> > >  drivers/iio/adc/Makefile                      |    1 +
> > >  drivers/iio/adc/ti-ads7142.c                  | 1469 +++++++++++++++=
++
> > >  5 files changed, 1501 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ad=
s7142
> > >  create mode 100644 drivers/iio/adc/ti-ads7142.c
> > >
> ...
> > > +static int ti_ads7142_soft_reset(const struct i2c_client *client)
> > > +{
> > > +       u8 buf[2] =3D { TI_ADS7142_OC_GENERAL, 0x06 };
> > > +       int ret;
> > > +
> > > +       ret =3D i2c_master_send(client, buf, sizeof(buf));
> > > +       if (ret >=3D 0 && ret !=3D sizeof(buf))
> > > +               ret =3D -EIO;
> > > +
> > > +       return ret =3D=3D sizeof(buf) ? 0 : ret;
> > > +}
> > > +
> > > +static int ti_ads7142_address2channel(struct iio_dev *indio_dev,
> > > +                                     int address,
> > > +                                     struct ti_ads7142_channel **cha=
nnel)
> >
> > This could be simplified a bit to return "const struct
> > ti_ads7142_channel *" and then when NULL is returned, the caller
> > assumes -ENODEV.
> > Though, in  ti_ads7142_ist()  care should be taken to assign  ret =3D
> > -ENODEV; but that's only one place.
>
> I don't like returning with pointer, but I can live with it. I'll do that=
.

Personally, I don't have a strong opinion on the matter.
But kernel code tends to try to avoid double pointers [as parameters]
where possible.

Even the IS_ERR() / PTR_ERR() constructs suggest that.

>
> >
> >
> > > +{
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < indio_dev->num_channels; i++) {
> > > +               if (address =3D=3D priv->channels[i].channel) {
> > > +                       *channel =3D &priv->channels[i];
> > > +                       return 0;
> > > +               }
> > > +       }
> > > +       return -ENODEV;
> > > +}
> > > +
> > > +static int ti_ads7142_sequence_start(struct iio_dev *indio_dev)
> > > +{
> > > +       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.pa=
rent);
> > > +
> > > +       return ti_ads7142_reg_write(client, TI_ADS7142_START_SEQUENCE=
,
> > > +                                   TI_ADS7142_START_SEQUENCE_SEQ_STA=
RT);
> > > +}
> > > +
> ...
> > > +
> > > +static int ti_ads7142_buffered_setup_and_start(struct iio_dev *indio=
_dev)
> > > +{
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.pa=
rent);
> > > +       struct ti_ads7142_channel *channel;
> > > +       int i;
> > > +       u8 alert_ch =3D 0;
> > > +       u8 buffer_op_mode;
> > > +       u8 seq_channels =3D 0;
> > > +       int ret;
> > > +
> > > +       if (!priv->config.buffer_mode)
> > > +               return 0;
> > > +
> > > +       priv->monitor_pending =3D false;
> > > +
> > > +       ret =3D ti_ads7142_sequence_abort(indio_dev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D ti_ads7142_osc_set(indio_dev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D ti_ads7142_input_cfg_set(indio_dev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D ti_ads7142_dout_format_set(indio_dev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       switch (priv->config.buffer_mode) {
> > > +       case TI_ADS7142_BUFFM_STOP_BURST:
> > > +               buffer_op_mode =3D TI_ADS7142_DATA_BUFFER_OPMODE_STOP=
_BURST;
> > > +       break;
> > > +       case TI_ADS7142_BUFFM_START_BURST:
> > > +               buffer_op_mode =3D TI_ADS7142_DATA_BUFFER_OPMODE_STAR=
T_BURST;
> > > +       break;
> > > +       case TI_ADS7142_BUFFM_PRE_ALERT:
> > > +               buffer_op_mode =3D TI_ADS7142_DATA_BUFFER_OPMODE_PRE_=
ALERT;
> > > +       break;
> >
> > the indentation of the break; statements is a bit odd;
> > IIRC, they usually go aligned with the case block;
> > though i could be wrong;
>
> Ok, I'll fix it here and below.
>
> >
> > > +       case TI_ADS7142_BUFFM_POST_ALERT:
> > > +               buffer_op_mode =3D TI_ADS7142_DATA_BUFFER_OPMODE_POST=
_ALERT;
> > > +       break;
> > > +       default:
> > > +               return -EINVAL;
> > > +       break;
> >
> > also an unreachable statement
>
> Ok, I'll remove it here and below.
>
> >
> > > +       }
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_DATA_BUFFER_O=
PMODE,
> > > +                                  buffer_op_mode);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_OPMODE_SEL,
> > > +                                  TI_ADS7142_OPMODE_SEL_MONITORING);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       for_each_set_bit(i, indio_dev->active_scan_mask,
> > > +                        indio_dev->masklength) {
> > > +               seq_channels |=3D 1 << i;
> > > +       }
> > > +
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_AUTO_SEQ_CHEN=
,
> > > +                                  seq_channels);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (priv->config.buffer_mode < TI_ADS7142_BUFFM_PRE_ALERT)
> > > +               goto seq_start;
> > > +
> > > +       /*
> > > +        * Pre and post alert settings
> > > +        */
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_PRE_ALT_EVT_C=
NT, 0);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_ALT_LOW_FLAGS=
,
> > > +                                  TI_ADS7142_ALT_LOW_FLAGS_CH0
> > > +                                  | TI_ADS7142_ALT_LOW_FLAGS_CH1);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_ALT_HIGH_FLAG=
S,
> > > +                                  TI_ADS7142_ALT_HIGH_FLAGS_CH0
> > > +                                  | TI_ADS7142_ALT_HIGH_FLAGS_CH1);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       for_each_set_bit(i, indio_dev->active_scan_mask,
> > > +                        indio_dev->masklength) {
> > > +               ret =3D ti_ads7142_address2channel(indio_dev, i,
> > > +                                                &channel);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               ret =3D ti_ads7142_hth_set(indio_dev, channel->channe=
l,
> > > +                                        channel->config.high_thresho=
ld);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               ret =3D ti_ads7142_lth_set(indio_dev, channel->channe=
l,
> > > +                                        channel->config.low_threshol=
d);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               ret =3D ti_ads7142_hys_set(indio_dev, channel->channe=
l,
> > > +                                        channel->config.hysteresis);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               if (channel->config.alert_low ||
> > > +                   channel->config.alert_high) {
> > > +                       alert_ch |=3D 1 << channel->channel;
> > > +               }
> > > +       }
> > > +
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_ALERT_DWC_EN,
> > > +                                  alert_ch ? TI_ADS7142_ALERT_DWC_EN=
_BLOCK_EN : 0);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D ti_ads7142_reg_write(client, TI_ADS7142_ALERT_CHEN,
> > > +                                  alert_ch);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (!alert_ch)
> > > +               return ret;
> >
> > this looks the same as
> >           if (!alert_ch)
> >               return 0;
> > for a while, this looked like 'ret' was not initialized;
> >
>
> I've rethought this condition, and returning anything else than -EINVAL, =
is wrong.
>
> Story:
>   1. this get called first from triggered_buffer_preenable hook
>   2. the alert_ch =3D=3D 0 if no thresh_{rising/falling} enabled on any c=
hannel
>   3. returning 0 from here will cause that, the user waits for nothing
>
> > > +
> > > +seq_start:
> > > +       ret =3D ti_ads7142_sequence_start(indio_dev);
> > > +       priv->monitor_pending =3D !ret;
> > > +
> > > +       return ret;
> > > +}
> > > +
> ...
> > > +
> > > +static irqreturn_t ti_ads7142_ist(int irq, void *dev_id)
> > > +{
> > > +       struct iio_dev *indio_dev =3D dev_id;
> > > +       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.pa=
rent);
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       struct ti_ads7142_channel *channel;
> > > +       u8 low_flags;
> > > +       u8 high_flags;
> > > +       u8 seq_st;
> > > +       int i;
> > > +       int ret;
> > > +       int channel_collected;
> > > +       s64 timestamp =3D iio_get_time_ns(indio_dev);
> > > +
> > > +       mutex_lock(&priv->lock);
> > > +       if (!priv->config.buffer_mode || !priv->monitor_pending) {
> > > +               mutex_unlock(&priv->lock);
> > > +               return IRQ_NONE;
> > > +       }
> > > +
> > > +       /*
> > > +        * BUSY/PDY fires when the sequence stopped in
> > > +        * trigger handler(ti_ads7142_trigger_handler),
> > > +        * if buffer mode is stop_burst, all the required
> > > +        * operations are in trigger handler, so irq handler
> > > +        * simple returns at this point.
> > > +        */
> > > +       if (priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM_STOP_BUR=
ST) {
> > > +               mutex_unlock(&priv->lock);
> > > +               return IRQ_NONE;
> > > +       }
> > > +
> > > +       ret =3D ti_ads7142_reg_read(client, TI_ADS7142_SEQUENCE_STATU=
S, &seq_st);
> > > +       if (ret) {
> > > +               dev_err(indio_dev->dev.parent,
> > > +                       "%s: SEQUENCE_STATUS reg read error(%i)",
> > > +                       __func__, ret);
> > > +               goto final;
> > > +       }
> > > +
> > > +       if ((seq_st & TI_ADS7142_SEQUENCE_STATUS_SEQ_ERR_ST_MSK)
> > > +           !=3D TI_ADS7142_SEQUENCE_STATUS_SEQ_ENABLED) {
> > > +               dev_err(indio_dev->dev.parent,
> > > +                       "%s: SEQUENCE_STATUS error(%i)",
> > > +                       __func__, seq_st);
> > > +               goto final;
> > > +       }
> > > +
> > > +       ret =3D ti_ads7142_reg_read(client, TI_ADS7142_ALT_LOW_FLAGS,
> > > +                                 &low_flags);
> > > +       if (ret) {
> > > +               dev_err(indio_dev->dev.parent,
> > > +                       "%s: ALT_LOW_FLAGS reg read error(%i)",
> > > +                       __func__, ret);
> > > +               goto final;
> > > +       }
> > > +
> > > +       ret =3D ti_ads7142_reg_read(client, TI_ADS7142_ALT_HIGH_FLAGS=
,
> > > +                                 &high_flags);
> > > +       if (ret) {
> > > +               dev_err(indio_dev->dev.parent,
> > > +                       "%s: ALT_HIGH_FLAGS reg read error(%i)",
> > > +                       __func__, ret);
> > > +               goto final;
> > > +       }
> > > +
> > > +       ret =3D ti_ads7142_sequence_abort(indio_dev);
> > > +       if (ret)
> > > +               goto final;
> > > +
> > > +       priv->monitor_pending =3D false;
> > > +
> > > +       channel_collected =3D 0;
> > > +       ret =3D ti_ads7142_buffered_collect(indio_dev, &channel_colle=
cted);
> > > +       if (ret && ret !=3D -ENOENT) {
> > > +               dev_err(indio_dev->dev.parent,
> > > +                       "%s: error(%d) when collecting result for %s =
mode",
> > > +                       __func__, ret,
> > > +                       ti_ads7142_buffer_modes[priv->config.buffer_m=
ode]);
> > > +               goto final;
> > > +       }
> > > +
> > > +       if (ret =3D=3D -ENOENT)
> > > +               ret =3D 0;
> > > +
> > > +       if (!channel_collected)
> > > +               goto final;
> > > +
> > > +       if (priv->config.buffer_mode < TI_ADS7142_BUFFM_PRE_ALERT)
> > > +               goto final;
> > > +
> > > +       for_each_set_bit(i, indio_dev->active_scan_mask,
> > > +                        indio_dev->masklength) {
> > > +               ret =3D ti_ads7142_address2channel(indio_dev, i,
> > > +                                                &channel);
> > > +               if (ret)
> > > +                       goto final;
> > > +
> > > +               if (!(channel_collected & (1 << channel->channel)))
> > > +                       continue;
> > > +               if (channel->config.alert_low &&
> > > +                   (low_flags & (1 << channel->channel))) {
> > > +                       iio_push_event(indio_dev,
> > > +                                      IIO_UNMOD_EVENT_CODE(IIO_VOLTA=
GE,
> > > +                                                           i,
> > > +                                                           IIO_EV_TY=
PE_THRESH,
> > > +                                                           IIO_EV_DI=
R_FALLING),
> > > +                                      timestamp);
> > > +               }
> > > +
> > > +               if (channel->config.alert_high &&
> > > +                   (high_flags & (1 << channel->channel))) {
> > > +                       iio_push_event(indio_dev,
> > > +                                      IIO_UNMOD_EVENT_CODE(IIO_VOLTA=
GE,
> > > +                                                           i,
> > > +                                                           IIO_EV_TY=
PE_THRESH,
> > > +                                                           IIO_EV_DI=
R_RISING),
> > > +                                      timestamp);
> > > +               }
> > > +       }
> > > +
> > > +final:
> >
> > This final label looks a bit busy.
> > Maybe an idea would be to have 2 labels, and depdending on 'ret' you
> > do "goto {err,out}_unlock":
> >
> > out_unlock:
> >       if (priv->config.buffer_mode >=3D TI_ADS7142_BUFFM_PRE_ALERT) {
> >               ret =3D ti_ads7142_buffered_setup_and_start(indio_dev);
> >                if (ret) {
> >                       dev_err(indio_dev->dev.parent,
> >                               "%s: error(%d) when starting %s mode",
> >                               __func__, ret,
> >
> > ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> >                       goto err_unlock;
> >               }
> >       }
> >       mutex_unlock(&priv->lock);
> >       return IRQ_HANDLED;
> >
> > err_unlock:
> >        mutex_unlock(&priv->lock);
> >        return IRQ_NONE;
> >
> >
>
> You are right, I'll do that.
>
> > > +       if (!ret && priv->config.buffer_mode >=3D TI_ADS7142_BUFFM_PR=
E_ALERT) {
> > > +               ret =3D ti_ads7142_buffered_setup_and_start(indio_dev=
);
> > > +               if (ret) {
> > > +                       dev_err(indio_dev->dev.parent,
> > > +                               "%s: error(%d) when starting %s mode"=
,
> > > +                               __func__, ret,
> > > +                               ti_ads7142_buffer_modes[priv->config.=
buffer_mode]);
> > > +               }
> > > +       }
> > > +       mutex_unlock(&priv->lock);
> > > +       if (ret)
> > > +               return IRQ_NONE;
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int ti_ads7142_read_raw(struct iio_dev *indio_dev,
> > > +                              struct iio_chan_spec const *chan,
> > > +                              int *val, int *val2, long info)
> > > +{
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       int ret;
> > > +
> > > +       switch (info) {
> > > +       case IIO_CHAN_INFO_RAW:
> > > +               if (iio_buffer_enabled(indio_dev))
> > > +                       return -EBUSY;
> > > +               ret =3D iio_device_claim_direct_mode(indio_dev);
> > > +               if (ret)
> > > +                       return ret;
> > > +               ret =3D ti_ads7142_manual_read(indio_dev, chan->addre=
ss,
> > > +                                            val);
> > > +               if (!ret)
> > > +                       ret =3D IIO_VAL_INT;
> > > +               iio_device_release_direct_mode(indio_dev);
> > > +               return ret;
> > > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > > +               ti_ads7142_osc_calc_get(indio_dev, val);
> > > +               return IIO_VAL_INT;
> > > +       case IIO_CHAN_INFO_SCALE:
> > > +               if (IS_ERR(priv->avdd)) {
> > > +                       ret =3D -EINVAL;
> > > +               } else {
> > > +                       *val =3D regulator_get_voltage(priv->avdd) / =
1000;
> > > +                       *val2 =3D chan->scan_type.realbits;
> > > +                       ret =3D IIO_VAL_FRACTIONAL_LOG2;
> > > +               }
> >
> > purely stylistic change; but this could also be:
> >
> >               if (IS_ERR(priv->avdd))
> >                   return -EINVAL
> >
> >               *val =3D regulator_get_voltage(priv->avdd) / 1000;
> >               *val2 =3D chan->scan_type.realbits;
> >               return IIO_VAL_FRACTIONAL_LOG2;
> >
>
> Looks better, thank you.
>
> > > +               return ret;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +       return 0;
> >
> > This "return 0;" looks like an unreachable statement.
> > Some GCC versions complain about it. Not sure which.
> >
> > > +}
> > > +
> > > +static int ti_ads7142_write_raw(struct iio_dev *indio_dev,
> > > +                               struct iio_chan_spec const *chan,
> > > +                               int val, int val2, long mask)
> > > +{
> > > +       switch (mask) {
> > > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > > +               return ti_ads7142_osc_calc_set(indio_dev, val);
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> >
> > Also, an unreachale statement.
> >
>
> I'll remove these statements.
>
> > > +}
> > > +
> > > +static int ti_ads7142_read_event_value(struct iio_dev *indio_dev,
> > > +                                      const struct iio_chan_spec *ch=
an,
> > > +                                      enum iio_event_type type,
> > > +                                      enum iio_event_direction dir,
> > > +                                      enum iio_event_info info,
> > > +                                      int *val, int *val2)
> > > +{
> > > +       struct ti_ads7142_channel *channel;
> > > +       int ret;
> > > +
> > > +       ret =3D ti_ads7142_address2channel(indio_dev, chan->address,
> > > +                                        &channel);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       switch (info) {
> > > +       case IIO_EV_INFO_VALUE:
> > > +               if (dir =3D=3D IIO_EV_DIR_RISING)
> > > +                       *val =3D channel->config.high_threshold;
> > > +               else
> > > +                       *val =3D channel->config.low_threshold;
> > > +               return IIO_VAL_INT;
> > > +       case IIO_EV_INFO_HYSTERESIS:
> > > +               *val =3D channel->config.hysteresis;
> > > +               return IIO_VAL_INT;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +       return 0;
> >
> > Also an unreachable statement.
> >
> > > +}
> > > +
> ...
> > > +
> > > +static int ti_ads7142_triggered_buffer_preenable(struct iio_dev *ind=
io_dev)
> > > +{
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       int ret;
> > > +
> > > +       if (!priv->config.buffer_mode)
> > > +               return -EINVAL;
> > > +
> > > +       /*
> > > +        * Start/stop burst buffer modes requires trigger
> > > +        */
> > > +       if (priv->config.buffer_mode <=3D TI_ADS7142_BUFFM_START_BURS=
T &&
> > > +           !indio_dev->trig) {
> > > +               dev_err(indio_dev->dev.parent,
> > > +                       "%s: Start/stop burst buffer modes requires t=
rigger",
> > > +                       __func__);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       /*
> > > +        * Start burst and pre/post alert modes requires irq
> > > +        */
> > > +       if (priv->config.buffer_mode >=3D TI_ADS7142_BUFFM_START_BURS=
T &&
> > > +           !priv->irq_present) {
> > > +               dev_err(indio_dev->dev.parent,
> > > +                       "%s: Start burst and pre/post alert modes req=
uires irq",
> > > +                       __func__);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       priv->scan_data =3D devm_krealloc(indio_dev->dev.parent,
> > > +                                       priv->scan_data,
> > > +                                       indio_dev->scan_bytes, GFP_KE=
RNEL);
> >
> > the scan_data doesn't look like it would be awefully big;
> > so, it could be static buffer on 'priv';
> > it should be marked with ____cacheline_aligned  though  [if moved on
> > the priv object].
> > though, i don't feel too strongly about moving it;
> >
>
> Ok, I'll do that.
>
> >
> > > +       if (!priv->scan_data)
> > > +               return -ENOMEM;
> > > +
> > > +       mutex_lock(&priv->lock);
> > > +       /*
> > > +        * Start burst mode started in trigger handler.
> > > +        * Sequencer aborted here, just for safe.
> > > +        */
> > > +       if (priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM_START_BU=
RST)
> > > +               ret =3D ti_ads7142_buffered_abort(indio_dev);
> > > +       else
> > > +               ret =3D ti_ads7142_buffered_setup_and_start(indio_dev=
);
> > > +       mutex_unlock(&priv->lock);
> > > +
> > > +       return ret;
> > > +}
> > > +
> ...
> > > +
> > > +static irqreturn_t ti_ads7142_trigger_handler(int irq, void *p)
> > > +{
> > > +       struct iio_poll_func *pf =3D p;
> > > +       struct iio_dev *indio_dev =3D pf->indio_dev;
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       int ret =3D 0;
> > > +
> > > +       mutex_lock(&priv->lock);
> > > +       if (priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM_STOP_BUR=
ST) {
> > > +               ret =3D ti_ads7142_buffered_abort(indio_dev);
> > > +               if (ret) {
> > > +                       dev_err(indio_dev->dev.parent,
> > > +                               "%s: error(%d) when aborting in %s mo=
de",
> > > +                               __func__, ret,
> > > +                               ti_ads7142_buffer_modes[priv->config.=
buffer_mode]);
> > > +               }
> > > +
> > > +               ret =3D ti_ads7142_buffered_collect(indio_dev, NULL);
> > > +               if (ret && ret !=3D -ENOENT) {
> > > +                       dev_err(indio_dev->dev.parent,
> > > +                               "%s: error(%d) when collecting result=
 for %s mode",
> > > +                               __func__, ret,
> > > +                               ti_ads7142_buffer_modes[priv->config.=
buffer_mode]);
> > > +               }
> > > +
> > > +               if (ret =3D=3D -ENOENT)
> > > +                       ret =3D 0;
> > > +       }
> > > +       if (!ret &&
> > > +           (priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM_START_B=
URST ||
> > > +            priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM_STOP_BU=
RST)) {
> > > +               ret =3D ti_ads7142_buffered_setup_and_start(indio_dev=
);
> > > +               if (ret) {
> > > +                       dev_err(indio_dev->dev.parent,
> > > +                               "%s: error(%d) when starting %s mode"=
,
> > > +                               __func__, ret,
> > > +                               ti_ads7142_buffer_modes[priv->config.=
buffer_mode]);
> > > +               }
> > > +       }
> > > +
> > > +       mutex_unlock(&priv->lock);
> > > +
> > > +       if (ret)
> > > +               return IRQ_NONE;
> >
> > maybe doing 2 labels here (with goto err_unlock/out_unlock) would be
> > an idea here as well;
> >
>
> Ok, I'll do that.
>
> > > +
> > > +       iio_trigger_notify_done(indio_dev->trig);
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> ...
> > > +
> > > +static const struct iio_chan_spec_ext_info ti_ads7142_ext_info[] =3D=
 {
> > > +       IIO_ENUM("buffer_mode", IIO_SHARED_BY_ALL,
> > > +                &ti_ads7142_buffer_modes_enum),
> > > +       {
> > > +               .name =3D "buffer_mode_available",
> > > +               .shared =3D IIO_SHARED_BY_ALL,
> > > +               .read =3D iio_enum_available_read,
> > > +               .private =3D (uintptr_t)&ti_ads7142_buffer_modes_enum=
,
> > > +       },
> > > +       { },
> >
> > the comma can be removed here;
> > since it's a null terminator;
> >
>
> Ok, I'll remove it.
>
> > > +};
> > > +
> > > +static int ti_ads7142_parse_channel_config(struct device *dev,
> > > +                                          struct iio_dev *indio_dev)
> > > +{
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       struct fwnode_handle *channel_node;
> > > +       struct iio_chan_spec *iio_channels;
> > > +       struct iio_chan_spec *iio_channel;
> > > +       struct ti_ads7142_channel *ads_channel;
> > > +       int channel_index =3D 0;
> > > +       int channel_count;
> > > +       int ret;
> > > +
> > > +       channel_count =3D device_get_child_node_count(dev);
> > > +       if (!channel_count) {
> > > +               dev_err(dev, "dt: there is no channel definition");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       if (channel_count > TI_ADS7142_CHANNEL_COUNT) {
> > > +               dev_err(dev, "dt: invalid number of channel definitio=
ns");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       priv->channels =3D devm_kcalloc(dev, channel_count,
> > > +                                     sizeof(*priv->channels),
> > > +                                     GFP_KERNEL);
> > > +       if (!priv->channels)
> > > +               return -ENOMEM;
> >
> > It looks to me that this device has up-to 2 channels.
> > For such a low channel count, it may make sense to just keep a static
> > table of iio_channels pointers [1].
> >
> > > +
> > > +       indio_dev->num_channels =3D channel_count;
> > > +       iio_channels =3D devm_kcalloc(dev, channel_count, sizeof(*iio=
_channels),
> > > +                                   GFP_KERNEL);
> > > +       if (!iio_channels)
> > > +               return -ENOMEM;
> > > +
> > > +       indio_dev->channels =3D iio_channels;
> > > +
> > > +       device_for_each_child_node(dev, channel_node) {
> > > +               ads_channel =3D &priv->channels[channel_index];
> > > +
> > > +               ret =3D fwnode_property_read_u32(channel_node, "reg",
> > > +                                              &ads_channel->channel)=
;
> > > +               if (ret) {
> > > +                       fwnode_handle_put(channel_node);
> > > +                       return ret;
> > > +               }
> > > +
> > > +               iio_channel =3D &iio_channels[channel_index];
> > > +               iio_channel->datasheet_name =3D ti_ads7142_ain_names[=
ads_channel->channel];
> > > +               iio_channel->type =3D IIO_VOLTAGE;
> > > +               iio_channel->indexed =3D 1;
> > > +               iio_channel->info_mask_separate =3D BIT(IIO_CHAN_INFO=
_RAW);
> > > +               if (!IS_ERR_OR_NULL(priv->avdd))
> > > +                       iio_channel->info_mask_separate |=3D BIT(IIO_=
CHAN_INFO_SCALE);
> > > +               iio_channel->info_mask_shared_by_all =3D BIT(IIO_CHAN=
_INFO_SAMP_FREQ);
> > > +               iio_channel->scan_type.sign =3D 'u';
> > > +               iio_channel->scan_type.realbits =3D 12;
> > > +               iio_channel->scan_type.storagebits =3D 16;
> > > +               iio_channel->scan_type.endianness =3D IIO_CPU;
> > > +               iio_channel->address =3D ads_channel->channel;
> > > +               iio_channel->scan_index =3D ads_channel->channel;
> > > +               iio_channel->channel =3D ads_channel->channel;
> > > +               iio_channel->event_spec =3D ti_ads7142_events;
> > > +               iio_channel->num_event_specs =3D ARRAY_SIZE(ti_ads714=
2_events);
> > > +               iio_channel->ext_info =3D ti_ads7142_ext_info;
> > > +
> > > +               ads_channel->config.high_threshold =3D TI_ADS7142_THR=
ESHOLD_MSK;
> > > +               channel_index++;
> >
> > Also, here I think it may make sense to keep a global const-static
> > table of iio_channel object-parameters.
> > Then it can be assigned to the iio_channels [1] pointer-list and then
> > to indio_dev->channels/num_channels.
>
> This device have more features, like high precision mode(16 bits of data)=
 and pseudo-differential mode.
>  I would implement these features in the next weeks/months.
>  So I would keep this dynamic initialization, and after the features abov=
e has implemented,
>  I'll change it to static, if it will optimal.

So, you can always choose to allocate iio_channels later.

Or you can do it now, and a global-static "iio_channel[s]" object as templa=
te.
See this example:
  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/driver=
s/iio/adc/ad7124.c#n794
It's essentially a memcpy() done via C compiler, where a lot of the
base information from the channel is stored in a global-const object
and copied over.
Then if something else needs tuning, it is applied from the DT,.

>
> >
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int ti_ads7142_parse_config(struct device *dev,
> > > +                                  struct iio_dev *indio_dev)
> > > +{
> > > +       return ti_ads7142_parse_channel_config(dev, indio_dev);
> > > +}
> > > +
> > > +static void ti_ads7142_regulators_disable(void *data)
> > > +{
> > > +       struct ti_ads7142_priv *priv =3D data;
> > > +
> > > +       if (!IS_ERR_OR_NULL(priv->avdd))
> > > +               regulator_disable(priv->avdd);
> > > +       if (!IS_ERR_OR_NULL(priv->dvdd))
> > > +               regulator_disable(priv->dvdd);
> > > +}
> >
> > So, I've also learned this the hard way, but the general rule of these
> > callbacks is one per resource.
> > Something like:
> >
> > static void ti_ads7142_regulators_disable(void *reg)
> > {
> >         regulator_disable(reg);
> > }
> >
>
> Thank you for sharing your experience, I will do this
>
> > Then some calls are needed for each regulator.
> > Also, IS_ERR() can be used instead of IS_ERR_OR_NULL()
> > {devm_}regulator_get() always returns non-NULL.
>
> The devm_regulator_get() can return NULL, if the CONFIG_REGULATOR is not =
selected.

Oh right.
My bad here. [1]

>   I didnt saw any system without CONFIG_REGULATOR, but who knows...
>   See: include/linux/regulator/consumer.h line:325

I guess the thing is that the usual construct is:
         priv->avdd =3D devm_regulator_get(&client->dev, "avdd");
         if (IS_ERR(priv->avdd))
             return PTR(priv->avdd);
Maybe there was a broader discussion about regulators being NULL, but
from the code in other drivers, this doesn't seem to be the case.

>
> >
> >
> >         priv->avdd =3D devm_regulator_get(&client->dev, "avdd");
> >         if (!IS_ERR(priv->avdd)) {
> >                 ret =3D regulator_enable(priv->avdd);
> >                 if (ret)
> >                         return ret;
> >
> >                 ret =3D devm_add_action_or_reset(&client->dev,
> >                                                ti_ads7142_regulators_di=
sable,
> >                                                priv->avdd);
> >                 if (ret)
> >                         return ret;
> >         }
> >
> >         priv->dvdd =3D devm_regulator_get(&client->dev, "dvdd");
> >         if (!IS_ERR(priv->dvdd)) {
> >                 ret =3D regulator_enable(priv->dvdd);
> >                 if (ret)
> >                         return ret;
> >
> >                 ret =3D devm_add_action_or_reset(&client->dev,
> >                                                ti_ads7142_regulators_di=
sable,
> >                                                priv->dvdd);
> >                 if (ret)
> >                         return ret;
> >         }
> >
> >
> > > +
> > > +static int ti_ads7142_probe(struct i2c_client *client,
> > > +                           const struct i2c_device_id *id)
> > > +{
> > > +       struct iio_dev *indio_dev;
> > > +       struct ti_ads7142_priv *priv;
> > > +       int ret;
> > > +
> > > +       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*pri=
v));
> > > +       if (!indio_dev)
> > > +               return -ENOMEM;
> > > +
> > > +       i2c_set_clientdata(client, indio_dev);
> > > +       priv =3D iio_priv(indio_dev);
> > > +
> > > +       /**
> > > +        * starting from v5.9-rc1 iio_device_alloc
> > > +        *  sets indio_dev->dev.parent, but older versions not :(
> > > +        **/
> > > +       if (!indio_dev->dev.parent)
> > > +               indio_dev->dev.parent =3D &client->dev;
> > > +       indio_dev->name =3D TI_ADS7142_NAME;
> > > +       indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWAR=
E;
> > > +       indio_dev->info =3D &ti_ads7142_iio_info;
> > > +
> > > +       priv->avdd =3D devm_regulator_get(&client->dev, "avdd");
> > > +       if (!IS_ERR_OR_NULL(priv->avdd)) {
> > > +               ret =3D regulator_enable(priv->avdd);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       priv->dvdd =3D devm_regulator_get(&client->dev, "dvdd");
> > > +       if (!IS_ERR_OR_NULL(priv->dvdd)) {
> > > +               ret =3D regulator_enable(priv->dvdd);
> > > +               if (ret)
> > > +                       goto final;
> > > +       }
> > > +
> > > +       ret =3D devm_add_action_or_reset(&client->dev,
> > > +                                      ti_ads7142_regulators_disable,
> > > +                                      priv);
> > > +       if (ret)
> > > +               goto final;
> > > +
> > > +       ret =3D ti_ads7142_soft_reset(client);
> > > +       if (ret)
> > > +               goto final;
> > > +
> > > +       ret =3D ti_ads7142_parse_config(&client->dev, indio_dev);
> > > +       if (ret)
> > > +               goto final;
> > > +
> > > +       mutex_init(&priv->lock);
> > > +
> > > +       if (client->irq) {
> > > +               ret =3D devm_request_threaded_irq(&client->dev, clien=
t->irq,
> > > +                                               NULL, ti_ads7142_ist,
> > > +                                               IRQF_ONESHOT | IRQF_S=
HARED,
> > > +                                               dev_name(&client->dev=
),
> > > +                                               indio_dev);
> > > +               if (ret) {
> > > +                       dev_err(&client->dev, "Unable to request IRQ =
%i",
> > > +                               client->irq);
> > > +                       goto final;
> > > +               }
> > > +               priv->irq_present =3D true;
> > > +       }
> > > +
> > > +       ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> > > +                                             indio_dev,
> > > +                                             &iio_pollfunc_store_tim=
e,
> > > +                                             &ti_ads7142_trigger_han=
dler,
> > > +                                             &ti_ads7142_triggered_b=
uffer_ops);
> > > +       if (ret)
> > > +               goto final;
> > > +
> > > +       ret =3D devm_iio_device_register(&client->dev, indio_dev);
> >
> > Usually "return devm_iio_device_register(&client->dev, indio_dev);" is
> > sufficient.
> > The rest is syslog spam.
>
> Ok, I'll do that.
>
> >
> > > +       if (ret) {
> > > +               dev_err(&client->dev, "Failed to register iio device"=
);
> > > +               goto final;
> > > +       }
> > > +
> > > +       dev_info(&client->dev, "%s is a %s device at address 0x%X",
> > > +                dev_name(&indio_dev->dev), indio_dev->name,
> > > +                client->addr);
> > > +final:
> >
> > This 'final' label looks odd.
> > It looks like all 'goto final' calls in this function could be
> > replaced with 'return ret'
> > And the return below could be 'return 0;'
>
> Yes, you are right, this is not required, I'll remove it.
>
> >
> >
> > > +       return ret;
> > > +}
> > > +
> > > +static int __maybe_unused ti_ads7142_suspend(struct device *dev)
> > > +{
> > > +       struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_clien=
t(dev));
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +
> > > +       mutex_lock(&priv->lock);
> > > +       do {
> > > +               /*
> > > +                * Keep all regulators on when the device in autonomo=
us
> > > +                *  monitoring mode.
> > > +                * The device can wake up the system with ALERT pin
> > > +                */
> > > +               if (priv->monitor_pending &&
> > > +                   (priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM=
_PRE_ALERT ||
> > > +                    priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM=
_POST_ALERT))
> > > +                       continue;
> > > +
> > > +               if (!IS_ERR_OR_NULL(priv->avdd))
> > > +                       regulator_disable(priv->avdd);
> > > +               if (!IS_ERR_OR_NULL(priv->dvdd))
> > > +                       regulator_disable(priv->dvdd);
> > > +       } while (0);
> > > +       mutex_unlock(&priv->lock);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int __maybe_unused ti_ads7142_resume(struct device *dev)
> > > +{
> > > +       struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_clien=
t(dev));
> > > +       struct ti_ads7142_priv *priv =3D iio_priv(indio_dev);
> > > +       int ret =3D 0;
> > > +
> > > +       mutex_lock(&priv->lock);
> > > +       do {
> > > +               /*
> > > +                * Nothing to do when the device in autonomous monito=
ring mode.
> > > +                */
> > > +               if (priv->monitor_pending &&
> > > +                   (priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM=
_PRE_ALERT ||
> > > +                    priv->config.buffer_mode =3D=3D TI_ADS7142_BUFFM=
_POST_ALERT))
> > > +                       continue;
> > > +
> > > +               if (!IS_ERR_OR_NULL(priv->avdd)) {
> > > +                       ret =3D regulator_enable(priv->avdd);
> > > +                       if (ret)
> > > +                               continue;
> > > +               }
> > > +               if (!IS_ERR_OR_NULL(priv->dvdd)) {
> > > +                       ret =3D regulator_enable(priv->dvdd);
> > > +                       if (ret)
> > > +                               continue;
> > > +               }
> > > +       } while (0);
> >
> > This while(0) loop looks a bit funky.
> > I understand why it's here; but it still looks a bit weird.
> >
>
> It is a short block and readable.
>
> > > +       mutex_unlock(&priv->lock);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(ti_ads7142_pm_ops, ti_ads7142_suspend,
> > > +                        ti_ads7142_resume);
> > > +
> > > +static const struct i2c_device_id ti_ads7142_id[] =3D {
> > > +       { TI_ADS7142_NAME, 0 },
> > > +       { }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, ti_ads7142_id);
> > > +
> > > +static const struct of_device_id ti_ads7142_of_match[] =3D {
> > > +       { .compatible =3D "ti,ads7142" },
> > > +       {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ti_ads7142_of_match);
> > > +
> > > +static struct i2c_driver ti_ads7142_driver =3D {
> > > +       .driver =3D {
> > > +               .name =3D TI_ADS7142_NAME,
> > > +               .of_match_table =3D ti_ads7142_of_match,
> > > +               .pm =3D &ti_ads7142_pm_ops,
> > > +       },
> > > +       .probe          =3D ti_ads7142_probe,
> > > +       .id_table       =3D ti_ads7142_id,
> > > +};
> > > +
> > > +module_i2c_driver(ti_ads7142_driver);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_AUTHOR("Jozsef Horvath <info@ministro.hu>");
> > > +MODULE_DESCRIPTION("Texas Instruments ADS7142 ADC driver");
> > > --
> > > 2.17.1
> > >
> > >
>
> Thank you for review and suggestions.
>
> Best regards
> J=C3=B3zsef
>
