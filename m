Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3B600BC9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJQJ7v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJQJ7u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 05:59:50 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA8CE7E
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 02:59:44 -0700 (PDT)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E234520008;
        Mon, 17 Oct 2022 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666000781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ju2ruVMd5poDtskfrZUzVLBoJhl/wGS81SOZUQfqfQ=;
        b=KXcSgIRB+yXNgvOUpibHDIBwJ7zhesMHhzi6kG/9/KKb4JMVwnSKTgMDEm9zS6eE4Z/eDB
        rPj+ZvLW1M0HdLjRlrvXxAHD5DAOSQ0VlLAquwbeHNIaVl5vk+ugfw6/9DUaJypkx6xJKt
        Z2VfxJMCOhiNu1+OUNih+ZG9XdfEzuTSDlv4w8Vgshtyf2KJKfKv4BuY3ajvwvH7H9QrrL
        dtP5HlL18nETzeX978wzTTzoBZ+/iHv/ysfSq9IGCa4qhCNgfNXzjw0cI8Su55F5oZd0/T
        A+xugTsJnrxPQUZF6+U8JtOSqj0CfvdTgF1hAcaadcWGKtov03dq52PZdwgsxQ==
Date:   Mon, 17 Oct 2022 11:59:37 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: Handling Signal1 in microchip-tcb-capture
Message-ID: <Y00nidri3TRYARiu@kb-xps>
References: <Y0q7Gzh95nFdqdYK@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0q7Gzh95nFdqdYK@fedora>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 15, 2022 at 09:52:27AM -0400, William Breathitt Gray wrote:
> Hello Kamel,
>

Hello William,

> I was looking over the microchip-tcb-capture driver recently and noticed
> that the code doesn't seem to account for Signal1. In particular, it
> appears that mchp_tc_count_signal_read() and mchp_tc_count_action_read()
> don't check the Signal id at all and just assume they are handling
> Signal0. This creates a situation where the information returned for the
> Signal1 sysfs attributes are just duplicated reports of Signal0.
>
> What exactly is the relationship of Signal0 ("Channel A") and Signal1
> ("Channel B"); is SignalB only relevant when the counter device is
> configured for quadrature mode?

Indeed both signals are required when in quadrature mode, where the
signal0 is representing the speed and signal1 the revolution or number
of rotation.

We have described all availables modes in details in the following blog post: https://bootlin.com/blog/timer-counters-linux-microchip/

Regards,
Kamel

>
> Sincerely,
>
> William Breathitt Gray



--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
