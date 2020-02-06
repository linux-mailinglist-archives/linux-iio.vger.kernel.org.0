Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96815452F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFNpL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 08:45:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40142 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFNpL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 08:45:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 88AFF295177
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
To:     Jonathan Cameron <jic23@kernel.org>,
        Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
 <20200205190028.183069-11-pmalani@chromium.org>
 <20200206121753.7b809631@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <671a55aa-1e5e-4e21-4a62-55db4dee368a@collabora.com>
Date:   Thu, 6 Feb 2020 14:45:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200206121753.7b809631@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Prashant,

On 6/2/20 13:17, Jonathan Cameron wrote:
> On Wed,  5 Feb 2020 11:00:13 -0800
> Prashant Malani <pmalani@chromium.org> wrote:
> 
>> Replace cros_ec_cmd_xfer_status() with cros_ec_cmd()
>> which does the message buffer setup and cleanup.
>>
>> For one other usage, replace the cros_ec_cmd_xfer_status() call with a
>> call to cros_ec_cmd_xfer(), in preparation for the removal of the former
>> function.
>>
>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>
>> Changes in v2:
>> - Updated to use new function name and parameter list.
>> - Used C99 element setting to initialize param struct.
>> - For second usage, replaced cros_ec_cmd_xfer_status() with
>>   cros_ec_cmd_xfer() which is functionally similar.
>>
>>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> index d3a3626c7cd834..94e22e7d927631 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> @@ -30,24 +30,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>>  					     u16 cmd_offset, u16 cmd, u32 *mask)
>>  {
>>  	int ret;
>> -	struct {
>> -		struct cros_ec_command msg;
>> -		union {
>> -			struct ec_params_get_cmd_versions params;
>> -			struct ec_response_get_cmd_versions resp;
>> -		};
>> -	} __packed buf = {
>> -		.msg = {
>> -			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
>> -			.insize = sizeof(struct ec_response_get_cmd_versions),
>> -			.outsize = sizeof(struct ec_params_get_cmd_versions)
>> -			},
>> -		.params = {.cmd = cmd}
>> +	struct ec_params_get_cmd_versions params = {
>> +		.cmd = cmd,
>>  	};
>> +	struct ec_response_get_cmd_versions resp = {0};
>>  
>> -	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
>> +	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS + cmd_offset,
>> +			  &params, sizeof(params), &resp, sizeof(resp), NULL);
>>  	if (ret >= 0)
>> -		*mask = buf.resp.version_mask;
>> +		*mask = resp.version_mask;
>>  	return ret;
>>  }
>>  
>> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>>  
>>  	memcpy(state->msg->data, &state->param, sizeof(state->param));
>>  
>> -	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
>> +	ret = cros_ec_cmd_xfer(state->ec, state->msg);
>>  	if (ret < 0)
>>  		return ret;
>> +	else if (state->msg->result != EC_RES_SUCCESS)
>> +		return -EPROTO;
>>  

There is no way to use the new cros_ec_cmd here?


>>  	if (ret &&
>>  	    state->resp != (struct ec_response_motion_sense *)state->msg->data)
> 
