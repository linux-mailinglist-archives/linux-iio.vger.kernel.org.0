Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156CF43E8A5
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJ1Syv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhJ1Syv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 14:54:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D5C061745
        for <linux-iio@vger.kernel.org>; Thu, 28 Oct 2021 11:52:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m21so7269130pgu.13
        for <linux-iio@vger.kernel.org>; Thu, 28 Oct 2021 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oj8b1YltTfZ/cg+gQfrWYqx1UkAbkYYTBArLJZRiaM=;
        b=ZeFp3SBvBp4ARPa8ebHoFGsyT3+l5VAX6PelB1W2NuODbMqvUYMCFWkDvx/YlM87po
         rpVv1dCQVXvbfwzWsSYrR13yvGWRVSNa7jCbJNPMk3HiNQZCikIcKU0Bj3RWiq2ABEp3
         8CxnjLo+YBgJOleWXLPt1526gwoG9MElzEHOe3Pbhm/Jdf96Vcdi9roJAwc50k6EALFu
         JTLW8uco/8lghzvCtIWet0Pivl4ot/X7ullTbUWs2qniAJxr/ZZPcYhvgAuGL4Q1KW4p
         VE5S8hx+OLxnnk90KCAOf31qp4CibZkYt6ErXfeSWFRAwRm2XZJRrdpHtrEfkwpnwL5g
         qYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oj8b1YltTfZ/cg+gQfrWYqx1UkAbkYYTBArLJZRiaM=;
        b=3PNNotYxA65jut/sJtmGreoRk1AAh26YEwN5kqScteHp9lTQjadQMG/yaNxf9H4oxA
         mB/+HtYSxSyUKK2CvUUt5wkykbf7t7cfycsY5wddfh1CZosqcpSjmfWNnM0FFnuwipIF
         t5QXdAxLgoiyvRY71+EojonfKMRHdMoR4WGqqdg+5GBhpUbLJ4AF2/hp5UADWq1BA4U0
         cF+hMbHAAETAnMIc2DAclNMmtWfLuKVeVh6mVdIOeOCRAYWxtaOlBpfZj52k4X7PdNtc
         aRl9DrxAN84LPX5BvhLcO6wgrFKwD3exrk/jv8B05LzcRBvc0zbN1bAOkizeNtlzAoZx
         ms7A==
X-Gm-Message-State: AOAM533odvBfWYrQpeLxlKydCHg4Y7a68zHoaL5EymEJQLz2tH9Ot+7M
        8MwZMR9wx+1iQliKgEdtIegelo7ZQL7ZAiclYBRMJQ==
X-Google-Smtp-Source: ABdhPJyUOntEEj03slcDQCZmaZTPfKYjZ6ob8Q5z72lkESLiYpNMhooFI80+b5ngvAHr8CCeMj3Mk6auzEK11K4/BoY=
X-Received: by 2002:aa7:9047:0:b0:44b:e142:8b0d with SMTP id
 n7-20020aa79047000000b0044be1428b0dmr6008619pfo.45.1635447143299; Thu, 28 Oct
 2021 11:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
 <20211024091627.28031-3-andriy.tryshnivskyy@opensynergy.com> <20211028150842.2e309268@jic23-huawei>
In-Reply-To: <20211028150842.2e309268@jic23-huawei>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Thu, 28 Oct 2021 11:52:12 -0700
Message-ID: <CA+=V6c0VNhC+GFbjCUP=3EtfQz-_n9mbKzAnzDYCze6Cqkrx9g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio/scmi: Add reading "raw" attribute.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Jyoti Bhayana <jbhayana@google.com>



On Thu, Oct 28, 2021 at 7:04 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 24 Oct 2021 12:16:27 +0300
> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>
> > Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
> > reading "raw" attribute in scmi_iio_read_raw.
> >
> > Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
>
> @Jyoti,
>
> looking for your Ack / or Reviewed-by tag for this one.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes comparing v6 -> v7:
> > * split into two patches: one for changes in core functionality,
> >   another - for changes in the driver
> >
> > Changes comparing v5 -> v6:
> > * revert v5 changes since with scmi_iio_read_raw() the channel
> >   can't be used by in kernel users (iio-hwmon)
> > * returned to v3 with direct mode
> > * introduce new type IIO_VAL_INT_64 to read 64-bit value
> >
> > Changes comparing v4 -> v5:
> > * call iio_device_release_direct_mode() on error
> > * code cleanup, fix typo
> >
> > Changes comparing v3 -> v4:
> > * do not use scmi_iio_get_raw() for reading raw attribute due to 32-bit
> >   return value limitation (actually I reverted the previous v3)
> > * introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return
> >   64-bit value
> > * enabling/disabling and reading raw attribute is done in direct mode
> >
> > Changes comparing v2 -> v3:
> > * adaptation for changes in structure scmi_iio_priv (no member
> >   named 'handle')
> >
> > Changes comparing v0 -> v2:
> > * added an error return when the error happened during config_set
> > * removed redundant cast for "readings"
> > * added check if raw value fits 32 bits
> >
> >  drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
> >  1 file changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > index 7cf2bf282cef..d538bf3ab1ef 100644
> > --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> > +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > @@ -279,6 +279,52 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> >       return 0;
> >  }
> >
> > +static int scmi_iio_read_channel_data(struct iio_dev *iio_dev,
> > +                          struct iio_chan_spec const *ch, int *val, int *val2)
> > +{
> > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > +     u32 sensor_config;
> > +     struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
> > +     int err;
> > +
> > +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > +                                     SCMI_SENS_CFG_SENSOR_ENABLE);
> > +     err = sensor->sensor_ops->config_set(
> > +             sensor->ph, sensor->sensor_info->id, sensor_config);
> > +     if (err) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in enabling sensor %s err %d",
> > +                     sensor->sensor_info->name, err);
> > +             return err;
> > +     }
> > +
> > +     err = sensor->sensor_ops->reading_get_timestamped(
> > +             sensor->ph, sensor->sensor_info->id,
> > +             sensor->sensor_info->num_axis, readings);
> > +     if (err) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in reading raw attribute for sensor %s err %d",
> > +                     sensor->sensor_info->name, err);
> > +             return err;
> > +     }
> > +
> > +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > +                                     SCMI_SENS_CFG_SENSOR_DISABLE);
> > +     err = sensor->sensor_ops->config_set(
> > +             sensor->ph, sensor->sensor_info->id, sensor_config);
> > +     if (err) {
> > +             dev_err(&iio_dev->dev,
> > +                     "Error in disabling sensor %s err %d",
> > +                     sensor->sensor_info->name, err);
> > +             return err;
> > +     }
> > +
> > +     *val = lower_32_bits(readings[ch->scan_index].value);
> > +     *val2 = upper_32_bits(readings[ch->scan_index].value);
> > +
> > +     return IIO_VAL_INT_64;
> > +}
> > +
> >  static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> >                            struct iio_chan_spec const *ch, int *val,
> >                            int *val2, long mask)
> > @@ -300,6 +346,14 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> >               ret = scmi_iio_get_odr_val(iio_dev, val, val2);
> >               return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = iio_device_claim_direct_mode(iio_dev);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret = scmi_iio_read_channel_data(iio_dev, ch, val, val2);
> > +             iio_device_release_direct_mode(iio_dev);
> > +             return ret;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -381,7 +435,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
> >       iio_chan->type = type;
> >       iio_chan->modified = 1;
> >       iio_chan->channel2 = mod;
> > -     iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> > +     iio_chan->info_mask_separate =
> > +             BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
> >       iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> >       iio_chan->info_mask_shared_by_type_available =
> >               BIT(IIO_CHAN_INFO_SAMP_FREQ);
>
