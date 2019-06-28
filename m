Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4215986C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF1KcL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 06:32:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1KcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 06:32:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0687A27EA8A
Subject: Re: [PATCH 1/2] iio: common: cros_ec_sensors: determine protocol
 version
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>
References: <cover.1561642224.git.fabien.lahoudere@collabora.com>
 <4724b46665d919cae0ea3b60e334053b0b17d686.1561642224.git.fabien.lahoudere@collabora.com>
 <f8df78b4-8ae9-f292-cf70-ef682a4a47f4@collabora.com>
 <CAPUE2ut=imx=mhV_iyMwaYmfkFJ0zw3Jvsbxf+TbfqV1Sa_WJw@mail.gmail.com>
 <d1c6e0c7ec81b3cb780feecb919c068415b96000.camel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <82115f5d-3fcc-6358-6eb3-a8955671a063@collabora.com>
Date:   Fri, 28 Jun 2019 12:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <d1c6e0c7ec81b3cb780feecb919c068415b96000.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabien, Gwendal

On 28/6/19 11:36, Fabien Lahoudere wrote:
> Thanks Gwendal for reviewing.
> 
> Le jeudi 27 juin 2019 à 14:59 -0700, Gwendal Grignou a écrit :
>> On Thu, Jun 27, 2019 at 8:59 AM Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>> Hi,
>>>
>>> cc'ing Doug, Gwendal and Enrico that might be interested to give a
>>> review.
>>>
>>> This patch can be picked alone without 2/2, an is needed to have
>>> cros-ec-sensors
>>> legacy support on ARM (see [1] and [2])
>>>
>>> Jonathan, as [1] and [2] will go through the chrome-platform tree
>>> if you don't
>>> mind I'd also like to carry with this patch once you're fine with
>>> it.
>>>
>>> Thanks,
>>> ~ Enric
>>>
>>> [1] https://patchwork.kernel.org/patch/11014329/
>>> [2] https://patchwork.kernel.org/patch/11014327/
>>>
>>> On 27/6/19 16:04, Fabien Lahoudere wrote:
>>>> This patch adds a function to determine which version of the
>>>> protocol is used to communicate with EC.
>>>>
>>>> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
>>>> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
>>>
>>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>
>>>> ---
>>>>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 36
>>>> ++++++++++++++++++-
>>>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git
>>>> a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>> b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>> index 130362ca421b..2e0f97448e64 100644
>>>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>>>> @@ -25,6 +25,31 @@ static char *cros_ec_loc[] = {
>>>>       [MOTIONSENSE_LOC_MAX] = "unknown",
>>>>  };
>>>>
>>>> +static int cros_ec_get_host_cmd_version_mask(struct
>>>> cros_ec_device *ec_dev,
>>>> +                                          u16 cmd_offset, u16
>>>> cmd, u32 *mask)
>>>> +{
>>>> +     int ret;
>>>> +     struct {
>>>> +             struct cros_ec_command msg;
>>>> +             union {
>>>> +                     struct ec_params_get_cmd_versions params;
>>>> +                     struct ec_response_get_cmd_versions resp;
>>>> +             };
>>>> +     } __packed buf = {
>>>> +             .msg = {
>> add
>> .version = 0,
>> As the variable is coming from the stack, the version should be set.
> 

I think that from the C standard when using struct partial initialization in c
it follows the same rules as static so shouldn't be really needed. Anyway this
is always confusing me is for that I tend to use buf = { }; or memset the struct
and then assign the required values so it's clear that all the memebers of the
struct are initialized.


> Ack
> 
>>>> +                     .command = EC_CMD_GET_CMD_VERSIONS +
>>>> cmd_offset,
>>>> +                     .insize = sizeof(struct
>>>> ec_response_get_cmd_versions),
>>>> +                     .outsize = sizeof(struct
>>>> ec_params_get_cmd_versions)
>>>> +                     },
>>>> +             .params = {.cmd = cmd}
>>>> +     };
>>>> +
>>>> +     ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
>>>> +     if (ret >= 0)
>> It should be > 0: when the command is a success, it returns the
>> number
>> of byte in the response buffer. When don't expect == 0  here, because
>> when successful, EC_CMD_GET_CMD_VERSIONS will return a mask.
> 

Gwendal, from the downstream commit I see:

        ret = cros_ec_cmd_xfer_status(ec_dev, msg);
        if (ret >= 0) {
                if (msg->result == EC_RES_SUCCESS)
                        *mask = resp->version_mask;
                else
                        *mask = 0;
        }
        return ret;

I think we're confusing cros_ec_cmd_xfer_status() vs cros_ec_cmd_xfer()?

cros_ec_cmd_xfer_status() will return _only_ a value >= 0 value _if result is
EC_RES_SUCCESS_ otherwise will return a negative value (see
cros_ec_cmd_xfer_status() implementation). So the second check is not really
needed and the same can be implemented as:

        ret = cros_ec_cmd_xfer_status(ec_dev, msg);
        if (ret < 0)
                *mask = 0;
        else
                *mask = resp->version_mask;

        return ret;

But then I don't see the point to set the mask to 0 and even can be simplified as:

        ret = cros_ec_cmd_xfer_status(ec_dev, msg);
        if (ret < 0)
                return ret;

        *mask = msg.resp.version_mask;

        return 0;

So

cros_ec_get_host_cmd_version_mask() returns 0 on success or negative value on
error (protocol error || result != EC_RES_SUCCESS)


> Ack, so we assume that on success, 0 is not possible.
> 
>>>> +             *mask = buf.resp.version_mask;
>>>> +     return ret;
>>>> +}
>>>> +
>>>>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>>>>                             struct iio_dev *indio_dev,
>>>>                             bool physical_device)
>>>> @@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct
>>>> platform_device *pdev,
>>>>       struct cros_ec_sensors_core_state *state =
>>>> iio_priv(indio_dev);
>>>>       struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>>>>       struct cros_ec_sensor_platform *sensor_platform =
>>>> dev_get_platdata(dev);
>>>> +     u32 ver_mask;
>>>> +     int ret;
>>>>
>>>>       platform_set_drvdata(pdev, indio_dev);
>>>>
>>>> @@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct
>>>> platform_device *pdev,
>>>>
>>>>       mutex_init(&state->cmd_lock);
>>>>
>>>> +     ret = cros_ec_get_host_cmd_version_mask(state->ec,
>>>> +                                             ec->cmd_offset,
>>>> +                                             EC_CMD_MOTION_SENSE
>>>> _CMD,
>>>> +                                             &ver_mask);
>>>> +     if (ret < 0)
>> Use:
>> if (ret <= 0 || ver_mask == 0) {
>> In case the EC is really old or misbehaving, we don't want to set an
>> invalid version later.
> Ack, indeed the communication can work but with invalid data.


From the downstream commit:

        if (ret < 0 || ver_mask == 0) {
                dev_warn(dev, "Motionsense cmd version too old, aborting...\n");
                return -ENODEV;
        }

But with the above implementation is the same as

        if (ret < 0) {
                dev_warn(dev, "Motionsense cmd version too old, aborting...\n");
                return -ENODEV;
        }

Or I'm missing something and what we really want is to cover a corner case? I
such case I think we should use cros_ec_cmd_xfer() instead of
cros_ec_cmd_xfer_status()

Thanks,
~ Enric

>>>> +             return ret;
>>>> +
>>>>       /* Set up the host command structure. */
>>>> -     state->msg->version = 2;
>>>> +     state->msg->version = fls(ver_mask) - 1;;
>>>>       state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec-
>>>>> cmd_offset;
>>>>       state->msg->outsize = sizeof(struct
>>>> ec_params_motion_sense);
>>>>
>>>>
> 
