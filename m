Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49249F7062
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKKJUr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 04:20:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60384 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKJUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 04:20:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 10A7F28EB35
Subject: Re: [PATCH v4 08/17] Revert "Input: cros_ec_keyb: mask out extra
 flags in event_type"
To:     Gwendal Grignou <gwendal@chromium.org>, briannorris@chromium.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, Dmitry Torokhov <dtor@google.com>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-9-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b8abe5c0-991f-5ba2-daf9-de3e011e60fe@collabora.com>
Date:   Mon, 11 Nov 2019 10:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105222652.70226-9-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

cc'in Dmitry and linux-input list which is missing

On 5/11/19 23:26, Gwendal Grignou wrote:
> This reverts commit d096aa3eb6045a6a475a0239f3471c59eedf3d61.
> 
> This patch is not needed anymore since we clear EC_MKBP_HAS_MORE_EVENTS
> flag before calling the notifiers in patch
> "9d9518f5b52a (platform: chrome: cros_ec: handle MKBP more events flag)"
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> No changes in v4, v3.
> New to v2.
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index a29e81fdf186..2b71c5a51f90 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
>  		return NOTIFY_OK;
>  
> -	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
> +	switch (ckdev->ec->event_data.event_type) {
>  	case EC_MKBP_EVENT_KEY_MATRIX:
>  		pm_wakeup_event(ckdev->dev, 0);
>  
> 
