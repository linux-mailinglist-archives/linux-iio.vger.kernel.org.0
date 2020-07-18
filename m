Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A84224C96
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPkT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPkT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:40:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06F820734;
        Sat, 18 Jul 2020 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086818;
        bh=Ef/wssimir9zRGsU2Unu5vwADJof1NHFF3RCFsaYmBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IE/yPAoL0j/xAoh7S0Bwrj8qqJ8iq0l6I4GXzfKf8F6SPNrADXENwbS2VtUEx990O
         SS9Tpn/k9dP9kc+s75WzqSv64mogqsGf2SoD/EFykMdgR7eu1CZycr0Q1uCte7b4gu
         /Hb72BMXY7NFqO/zkpIIOcgmNKiKOWBdpuf+NTWY=
Date:   Sat, 18 Jul 2020 16:40:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH 07/30] iio: light: si1145: Demote obvious misuse of
 kerneldoc to standard comment blocks
Message-ID: <20200718164014.6acccbd6@archlinux>
In-Reply-To: <20200717165538.3275050-8-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-8-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:15 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> No attempt has been made to document any of the demoted functions here
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/light/si1145.c:192: warning: Function parameter or member 'data' not described in '__si1145_command_reset'
>  drivers/iio/light/si1145.c:228: warning: Function parameter or member 'data' not described in 'si1145_command'
>  drivers/iio/light/si1145.c:228: warning: Function parameter or member 'cmd' not described in 'si1145_command'
>  drivers/iio/light/si1145.c:1186: warning: Function parameter or member 'trig' not described in 'si1145_trigger_set_state'
>  drivers/iio/light/si1145.c:1186: warning: Function parameter or member 'state' not described in 'si1145_trigger_set_state'
> 
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Dan Leonard <leonard.crestez@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

J
> ---
>  drivers/iio/light/si1145.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 0476c2bc81384..37a6a59030929 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -181,7 +181,7 @@ struct si1145_data {
>  	int meas_rate;
>  };
>  
> -/**
> +/*
>   * __si1145_command_reset() - Send CMD_NOP and wait for response 0
>   *
>   * Does not modify data->rsp_seq
> @@ -215,7 +215,7 @@ static int __si1145_command_reset(struct si1145_data *data)
>  	}
>  }
>  
> -/**
> +/*
>   * si1145_command() - Execute a command and poll the response register
>   *
>   * All conversion overflows are reported as -EOVERFLOW
> @@ -1176,7 +1176,7 @@ static const struct iio_buffer_setup_ops si1145_buffer_setup_ops = {
>  	.validate_scan_mask = si1145_validate_scan_mask,
>  };
>  
> -/**
> +/*
>   * si1145_trigger_set_state() - Set trigger state
>   *
>   * When not using triggers interrupts are disabled and measurement rate is

