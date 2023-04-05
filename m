Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2C6D7EF6
	for <lists+linux-iio@lfdr.de>; Wed,  5 Apr 2023 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbjDEOPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Apr 2023 10:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbjDEOPo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2023 10:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AA5FCF;
        Wed,  5 Apr 2023 07:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D554F62441;
        Wed,  5 Apr 2023 14:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE1CC433D2;
        Wed,  5 Apr 2023 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680704089;
        bh=VeWciWEq9rNqtQglIzwXPtmlFx8XsntcElR1c2lwZ6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vbqm0jQPvTVoPCIeyRDlQHhrGCB63wmHaaWlEoQILdUqDtcwYlF74LKH70CDXGc3X
         9yuvuJFY6mIj55Q/G4lWRPQilWTElUbpauUPIJpAB3y2XOiLnVJvEty0MYYFi9ghs7
         fXAtIXVx4FjFD1s5beURfWpucZ7UTG9Vd1SG1VJI8T9TZJQDyvrqiUF2vpJuZZsdJX
         fb74FVVf9XR/tpDsZNdOMD5SwnoyXWgKnSFry8naB4LTE9Z0MK4PE4mjPMacv3iBI4
         O1znYuG5qRPCKfIXVj8150dfitcRMktYKdxC2MYxZ8dh6xtzHFQoEaJZxjukviVy79
         jx/CMsNMCuLIg==
Date:   Wed, 5 Apr 2023 15:14:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v15 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <20230405141444.GJ8371@google.com>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330111632.169434-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Mar 2023, Biju Das wrote:

> Add RZ/G2L MTU3a counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
>
> This patch adds 3 counter value channels.
> 	count0: 16-bit phase counter value channel on MTU1
> 	count1: 16-bit phase counter value channel on MTU2
> 	count2: 32-bit phase counter value channel by cascading
>                 MTU1 and MTU2 channels.
>
> The external input phase clock pin for the counter value channels
> are as follows:
> 	count0: "MTCLKA-MTCLKB"
> 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
>
> Use the sysfs variable "external_input_phase_clock_select" to select the
> external input phase clock pin and "cascade_counts_enable" to enable/
> disable cascading of channels.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
> Acked-by: William Breathitt Gray <william.gray@linaro.org>
> ---
> v14->v15:
>  * No change.
> v13->v14:
>  * Added Acked-by tag from William Breathitt Gray
>  * Replaced RZ_MTU1->RZ_MTU3_CHAN_1 and retained the Rb/ack tag as
>    it is trivial change.
> v12->v13:
>  * No change.
> v11->v12:
>  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is moved to MFD.
> v10->v11:
>  * Added Rb tag from William Breathitt Gray
>  * Replaced count2 channel name from "combined"->"cascaded", as channels
>    are cascaded
>  * Simplified the locking by adding the helper functions
>    rz_mtu3_lock_if_counter_is_valid, rz_mtu3_lock_if_count_is_enabled,
>    and rz_mtu3_lock_if_ch0_is_enabled.
> v9->v10:
>  * Added helper function for rz_mtu3_count_{action,function}_read
>  * Added priv->lock in rz_mtu3_count_function_read and rz_mtu3_count_
>    direction_read.
>  * Added ch->is_busy check for rz_mtu3_action_read()
>  * Added rz_mtu3_is_ch0_enabled() for device specific sysfs variables.
>  * Added ch->is_busy check for device specific sysfs variables.
> v8->v9:
>  * Added count_is_enabled variable to struct rz_mtu3_cnt
>  * Added check for ch->is_busy and count_is_enabled before every Counter
>    callback to ensure we do not try to access a busy channel used by other
>    subsystem(eg: pwm).
>  * Removed id parameter from rz_mtu3_32bit_cnt_setting()
>  * Made definition of rz_mtu3_get_ch() in single line.
>  * Replaced break->return in rz_mtu3_32bit_cnt_setting(),
>    rz_mtu3_count_function_read() and rz_mtu3_initialize_counter()
>    and removed redundant return 0.
>  * Simplified synapse signal check for rz_mtu3_action_read().
> v7->v8:
>  * Simplified rz_mtu3_initialize_counter by calling rz_mtu3_request_
>    channel() and release the acquired sibling channel in case of error.
>  * Simplified rz_mtu3_terminate_counter by calling rz_mtu3_release_
>    channel().
>  * Removed unused ceiling and ch_id from rz_mtu3_count_write()
>  * Replaced the error -EINVAL->-EBUSY for rz_mtu3_is_counter_invalid()
>  * Avoided race between rz_mtu3_count_{read, write} with rz_mtu3_
>    cascade_counts_enable_set() by adding locks and moved the lock
>    before rz_mtu3_is_counter_invalid()
>  * Protected the rz_mtu3_count_ceiling_read() function with a lock
>    to make sure the cascade operation mode doesn't not change and
>    that the priv data structure accesses don't race when they are
>    changed in the ceiling_write() callback.
>  * Added lock in rz_mtu3_cascade_enable_set() to make sure the other
>    callbacks don't try to read the LWA state while updating LWA.
>  * Added lock in rz_mtu3_ext_input_phase_clock_select_set() to ensure
>    the other callbacks don't try to read the PHCKSEL state while updating
>    PHCKSEL.
>  * Added lock to avoid race between rz_mtu3_count_function_write() and
>    rz_mtu3_action_read()
>  * Updated rz_mtu3_action_read to return 0, if Synapse is in COUNTER_SYNAPSE
>    _ACTION_NONE state.
>  * Replaced sysfs variable cascade_enable->cascade_counts_enable
>  * Renamed rz_mtu3_cascade_enable_get->rz_mtu3_cascade_counts_enable_get
>  * Renamed rz_mtu3_cascade_enable_set->rz_mtu3_cascade_counts_enable_set
>  * Removed redundent ceiling assignment from rz_mtu3_count_ceiling_read()
>  * Removed unused ceiling and ch_id from rz_mtu3_count_write().
> v6->v7:
>  * Updated commit description
>  * Added Register descriptions
>  * Opimized size of cache variable by using union
>  * Used test_bit() in rz_mtu3_is_counter_invalid()
>  * Replaced val->timer_mode in rz_mtu3_count_function_{read,write}
>  * Added TODO comment phase3 and phase5 modes.
>  * replaced if-else with ternary expression in rz_mtu3_count_direction_read()
>  * Used switch statement in rz_mtu3_count_ceiling_read to consistent with write
>  * Provided default case for all switch statement.
>  * Add mutex lock for avoiding races with other devices
>  * Updated comments in rz_mtu3_action_read
>  * Replaced COUNTER_COMP_DEVICE_BOOL->COUNTER_COMP_DEVICE_BOOL for
>    cascade_enable
>  * Replaced RZ_MTU3_GET_HW_CH->rz_mtu3_get_hw_ch
>  * Added rz_mtu3_get_ch() to get channels
>  * used rz_mtu3_shared_reg_update_bit for cascade_enable and
>    selecting phase input clock.
>  * Added rz_mtu3_is_counter_invalid() check in rz_mtu3_count_ceiling_read()
> v5->v6:
>  * Updated KConfig and commit description
>  * Sorted header
>  * Fixed RZ_MTU3_GET_HW_CH Macro for argument reuse 'id' -
>    possible side-effects?
>  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
>    __maybe_unused from suspend/resume()
> v4->v5:
>  * Updated the Kconfig with SoC vendor name
>  * Introduced rz_mtu3_is_counter_invalid()
>  * replaced pointer to an array of struct rz_mtu3_channel with
>    a simple pointer to struct rz_mtu3_channel.
>  * Added long_word_access_ctrl_mode sysfs entry for 16-bit and
>    32-bit access
>  * Added external_input_phase_clock_select sysfs entry for
>    selecting input clocks.
>  * used preprocessor defines represent SIGNAL_{A,B,C,D}_ID instead of
>    signal ids.
> v3->v4:
>  * There is no resource associated with "rz-mtu3-counter" compatible
>    and moved the code to mfd subsystem as it binds against "rz-mtu".
>  * Removed struct platform_driver rz_mtu3_cnt_driver.
>  * Updated commit description
>  * Updated Kconfig description
>  * Added macros RZ_MTU3_16_BIT_MTU{1,2}_CH for MTU1 and MTU2 channels
>  * Added RZ_MTU3_GET_HW_CH macro for getting channel ID.
>  * replaced priv->ch[id]->priv->ch[0] in rz_mtu3_count_read()
>  * Cached counter max values
>  * replaced cnt->tsr in rz_mtu3_count_direction_read()
>  * Added comments for RZ_MTU3_TCR_CCLR_NONE
>  * Replaced if with switch in rz_mtu3_initialize_counter() and
>    rz_mtu3_count_ceiling_write()
>  * Added locks in initialize, terminate and enable_read to prevent races.
>  * Updated rz_mtu3_action_read to take care of MTU2 signals.
>  * Added separate distinct array for each group of Synapse.
>  * Moved pm handling to parent.
>
> v1->v3:
>  * Modelled as a counter device supporting 3 counters(2 16-bit and
>    32-bit)
>  * Add kernel-doc comments to document struct rz_mtu3_cnt
>  * Removed mmio variable from struct rz_mtu3_cnt
>  * Removed cnt local variable from rz_mtu3_count_read()
>  * Replaced -EINVAL->-ERANGE for out of range error conditions.
>  * Removed explicit cast from write functions.
>  * Removed local variable val from rz_mtu3_count_ceiling_read()
>  * Added lock for RMW for counter/ceiling updates.
>  * Added different synapses for counter0 and counter{1,2}
>  * Used ARRAY for assigning num_counts.
>  * Added PM runtime for managing clocks.
>  * Add MODULE_IMPORT_NS(COUNTER) to import the COUNTER namespace.
> ---
>  drivers/counter/Kconfig       |  11 +
>  drivers/counter/Makefile      |   1 +
>  drivers/counter/rz-mtu3-cnt.c | 902 ++++++++++++++++++++++++++++++++++
>  3 files changed, 914 insertions(+)
>  create mode 100644 drivers/counter/rz-mtu3-cnt.c

Applied, thanks

--
Lee Jones [李琼斯]
