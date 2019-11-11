Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD8F705D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 10:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKJUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 04:20:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60374 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfKKJUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 04:20:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0656328EB4A
Subject: Re: [PATCH v4 07/17] Revert "Input: cros_ec_keyb - add back missing
 mask for event_type"
To:     Gwendal Grignou <gwendal@chromium.org>, briannorris@chromium.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, Dmitry Torokhov <dtor@google.com>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-8-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <30edd741-310a-9c94-78ed-74dec084f382@collabora.com>
Date:   Mon, 11 Nov 2019 10:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105222652.70226-8-gwendal@chromium.org>
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
> This reverts commit 62c3801619e16b68a37ea899b76572145dfe41c9.
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
>  drivers/input/keyboard/cros_ec_keyb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 8d4d9786cc74..a29e81fdf186 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -226,8 +226,6 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  {
>  	struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
>  						  notifier);
> -	uint8_t mkbp_event_type = ckdev->ec->event_data.event_type &
> -				  EC_MKBP_EVENT_TYPE_MASK;
>  	u32 val;
>  	unsigned int ev_type;
>  
> @@ -239,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
>  		return NOTIFY_OK;
>  
> -	switch (mkbp_event_type) {
> +	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
>  	case EC_MKBP_EVENT_KEY_MATRIX:
>  		pm_wakeup_event(ckdev->dev, 0);
>  
> @@ -266,7 +264,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	case EC_MKBP_EVENT_SWITCH:
>  		pm_wakeup_event(ckdev->dev, 0);
>  
> -		if (mkbp_event_type == EC_MKBP_EVENT_BUTTON) {
> +		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
>  			val = get_unaligned_le32(
>  					&ckdev->ec->event_data.data.buttons);
>  			ev_type = EV_KEY;
> 
