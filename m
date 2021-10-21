Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E174F4357E5
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 02:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhJUAmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 20:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJUAmu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 20:42:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78AC06161C
        for <linux-iio@vger.kernel.org>; Wed, 20 Oct 2021 17:40:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t7so9577561pgl.9
        for <linux-iio@vger.kernel.org>; Wed, 20 Oct 2021 17:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTK3PmiJo/50QG/bL2QbEDQCgeZMhZl/YHX7oJsYtK8=;
        b=EcP6GQ1xPAINy9hVWT13XDVT+iGLA2CiwM0gfssxx6+jr7oxx4bBntps1lG+QSHYs9
         Ce+h4JGfzsOLKTpsiVMnzaJR9P1HXMgyj5LwIVeuDbAJdkYl5fe95rC50GKXD/PCJM/S
         65nxPvjZ57gh17mxq4bBKcf3tIjD5DbN28GqidoUARevtwvFQJDB3ixq3ikLc+MOjCan
         e4ulaHsCoh/s3JvfNS8YhoOtipSfL/Im6SgDN6OEUn3rqxwi6GSbhbg2ZWnWWaRa+HS9
         qVSVRdySNtiKmusEYRLMCifi0OKXmPlXUUGhXNlq6SO49IraHT55yr6PzcG3vfCHdVY7
         P8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTK3PmiJo/50QG/bL2QbEDQCgeZMhZl/YHX7oJsYtK8=;
        b=IziuQq7W8Hqvza+uPJdrTe8I65CEUJHc2mVy476EEX27dKJcCbso6+y0U6QBAXz7Gj
         b8NsC4+tQ6RHf+49wryHz9RuNcwaPvZNgk1PCLlHQVX2zMc4HM9RdHYpwa5s/F9B43pW
         IKm4Q2HFzZmaGcmGaND1J+ADnFLrTv8xXreDrcfDZjA+K2FIoZUWxBlU8bSLqFdbNlVO
         SSRDjR50TH7vcxtPJa3PfSm7/HQfxQVO55uhpqOnJzQHu60++d21fhCtRyMqEQhadCrm
         WxVeLFR9+MRG0ckTjcUghZnVX3+t8PugxuHpdyf0U5ShZ9vtru/fM8NDTYBA4MXEr8aK
         /2IA==
X-Gm-Message-State: AOAM531TDl+v8qMvqmR0/dC0ghd4kZSiTMijyQUcysis3662JHksgRzn
        l6035dDR5Q4/hDfXsNxeZ1lMJUy8NYUO58BM1UNCD7+PpRc=
X-Google-Smtp-Source: ABdhPJzkIz/3AnBTYn5Q/44tdVdCx8+F4RmIvnvI9CRV57l+jPpZXfioRAY4OAfjIUi8ATILbu/10y3wXDCNHaM9zj4=
X-Received: by 2002:a63:6888:: with SMTP id d130mr1949025pgc.234.1634776834570;
 Wed, 20 Oct 2021 17:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
 <20211019075949.17644-2-andriy.tryshnivskyy@opensynergy.com>
 <20211020185118.7a02cbf8@jic23-huawei> <4e73398f-126a-0e1a-6eed-88d2d37778c2@opensynergy.com>
In-Reply-To: <4e73398f-126a-0e1a-6eed-88d2d37778c2@opensynergy.com>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Wed, 20 Oct 2021 17:40:23 -0700
Message-ID: <CA+=V6c1N8d6bB_2xKHjhygg_+45Grj9J2Z5UrdQAt6gDOtO=yw@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] iio/scmi: Add reading "raw" attribute.
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andriy,

Technically, the changes look good to me.

Thanks,
Jyoti

On Wed, Oct 20, 2021 at 11:57 AM Andriy Tryshnivskyy
<andriy.tryshnivskyy@opensynergy.com> wrote:
>
>
> On 20.10.21 20:51, Jonathan Cameron wrote:
>
> > CAUTION: This email originated from outside of the organization.
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> >
> >
> > On Tue, 19 Oct 2021 10:59:49 +0300
> > Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
> >
> >> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
> >> reading "raw" attribute in scmi_iio_read_raw.
> >> Introduce new type IIO_VAL_INT_64 to read 64-bit value
> >> for "raw" attribute.
> >>
> > Change log needs to be below the --- otherwise we'll store it forever
> > in git.  A linked tag (which will be generated when I apply)
> > is sufficient for this sort of historical info.
> >
> Sorry, this is my first patch, I was not aware of that.
> Thanks for the explanation.
> Quick question: since next version will include 2 patches,
> I guess a change log should be moved back to the cover letter, right?
>
>
> >> Changes comparing v5 -> v6:
> >> * revert v5 changes since with scmi_iio_read_raw() the channel
> >>    can't be used by in kernel users (iio-hwmon)
> >> * returned to v3 with direct mode
> >> * introduce new type IIO_VAL_INT_64 to read 64-bit value
> >>
> >> Changes comparing v4 -> v5:
> >> * call iio_device_release_direct_mode() on error
> >> * code cleanup, fix typo
> >>
> >> Changes comparing v3 -> v4:
> >> * do not use scmi_iio_get_raw() for reading raw attribute due to 32-bit
> >>    return value limitation (actually I reverted the previous v3)
> >> * introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return
> >>    64-bit value
> >> * enabling/disabling and reading raw attribute is done in direct mode
> >>
> >> Changes comparing v2 -> v3:
> >> * adaptation for changes in structure scmi_iio_priv (no member
> >>    named 'handle')
> >>
> >> Changes comparing v0 -> v2:
> >> * added an error return when the error happened during config_set
> >> * removed redundant cast for "readings"
> >> * added check if raw value fits 32 bits
> >>
> >> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> >> ---
> >>   drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
> >>   drivers/iio/industrialio-core.c            |  3 ++
> >>   include/linux/iio/types.h                  |  1 +
> > Two patches needed.  One to introduce the new core functionality then
> > a second to use it in the driver.
> >
> > Actual code looks good to me though I think I'd like a comment next to
> > the #define as not obvious which way around the two parts will go.
> >
> > There are some other places we will probably need to ultimately handle this
> > to allow for in kernel consumers but those can come when someone needs them.
> >
> > Will need an ack from Jyoti on this one though as driver author.
> > Thanks,
> >
> > Jonathan
>
> Sure, will split the current patch into two patches.
>
>
> >>   3 files changed, 60 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> >> index 7cf2bf282cef..2c1aec0fd5ff 100644
> >> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> >> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> >> @@ -279,6 +279,52 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> >>        return 0;
> >>   }
> >>
> >> +static int scmi_iio_read_channel_data(struct iio_dev *iio_dev,
> >> +                          struct iio_chan_spec const *ch, int *val, int *val2)
> >> +{
> >> +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> >> +     u32 sensor_config;
> >> +     struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
> >> +     int err;
> >> +
> >> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >> +                                     SCMI_SENS_CFG_SENSOR_ENABLE);
> >> +     err = sensor->sensor_ops->config_set(
> >> +             sensor->ph, sensor->sensor_info->id, sensor_config);
> >> +     if (err) {
> >> +             dev_err(&iio_dev->dev,
> >> +                     "Error in enabling sensor %s err %d",
> >> +                     sensor->sensor_info->name, err);
> >> +             return err;
> >> +     }
> >> +
> >> +     err = sensor->sensor_ops->reading_get_timestamped(
> >> +             sensor->ph, sensor->sensor_info->id,
> >> +             sensor->sensor_info->num_axis, readings);
> >> +     if (err) {
> >> +             dev_err(&iio_dev->dev,
> >> +                     "Error in reading raw attribute for sensor %s err %d",
> >> +                     sensor->sensor_info->name, err);
> >> +             return err;
> >> +     }
> >> +
> >> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >> +                                     SCMI_SENS_CFG_SENSOR_DISABLE);
> >> +     err = sensor->sensor_ops->config_set(
> >> +             sensor->ph, sensor->sensor_info->id, sensor_config);
> >> +     if (err) {
> >> +             dev_err(&iio_dev->dev,
> >> +                     "Error in disabling sensor %s err %d",
> >> +                     sensor->sensor_info->name, err);
> >> +             return err;
> >> +     }
> >> +
> >> +     *val = (u32)readings[ch->scan_index].value;
> >> +     *val2 = (u32)(readings[ch->scan_index].value >> 32)
> >> +
> >> +     return IIO_VAL_INT_64;
> >> +}
> >> +
> >>   static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> >>                             struct iio_chan_spec const *ch, int *val,
> >>                             int *val2, long mask)
> >> @@ -300,6 +346,14 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> >>        case IIO_CHAN_INFO_SAMP_FREQ:
> >>                ret = scmi_iio_get_odr_val(iio_dev, val, val2);
> >>                return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> >> +     case IIO_CHAN_INFO_RAW:
> >> +             ret = iio_device_claim_direct_mode(iio_dev);
> >> +             if (ret)
> >> +                     return ret;
> >> +
> >> +             ret = scmi_iio_read_channel_data(iio_dev, ch, val, val2);
> >> +             iio_device_release_direct_mode(iio_dev);
> >> +             return ret;
> >>        default:
> >>                return -EINVAL;
> >>        }
> >> @@ -381,7 +435,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
> >>        iio_chan->type = type;
> >>        iio_chan->modified = 1;
> >>        iio_chan->channel2 = mod;
> >> -     iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> >> +     iio_chan->info_mask_separate =
> >> +             BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
> >>        iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> >>        iio_chan->info_mask_shared_by_type_available =
> >>                BIT(IIO_CHAN_INFO_SAMP_FREQ);
> >> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> >> index 6d2175eb7af2..49e42d04ea16 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
> >>        }
> >>        case IIO_VAL_CHAR:
> >>                return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
> >> +     case IIO_VAL_INT_64:
> >> +             tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
> >> +             return sysfs_emit_at(buf, offset, "%lld", tmp2);
> >>        default:
> >>                return 0;
> >>        }
> >> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> >> index 84b3f8175cc6..e148fe11a3dc 100644
> >> --- a/include/linux/iio/types.h
> >> +++ b/include/linux/iio/types.h
> >> @@ -24,6 +24,7 @@ enum iio_event_info {
> >>   #define IIO_VAL_INT_PLUS_NANO 3
> >>   #define IIO_VAL_INT_PLUS_MICRO_DB 4
> >>   #define IIO_VAL_INT_MULTIPLE 5
> >> +#define IIO_VAL_INT_64 6
> > Possibly worth a descriptive comment. The other
> > types tend to make it easy to assume the role
> > of val and that of val2, in this case, val being
> > the lower 32 bits isn't obvious...
>
> I will add a comment here.
>
> Thank you for your review!
>
> Best regard,
> Andriy.
>
>
> >>   #define IIO_VAL_FRACTIONAL 10
> >>   #define IIO_VAL_FRACTIONAL_LOG2 11
> >>   #define IIO_VAL_CHAR 12
> >
