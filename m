Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D96695F80
	for <lists+linux-iio@lfdr.de>; Tue, 14 Feb 2023 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBNJnB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Feb 2023 04:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjBNJnA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2023 04:43:00 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0466CA07
        for <linux-iio@vger.kernel.org>; Tue, 14 Feb 2023 01:42:57 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 9DFCDDF00A8; Tue, 14 Feb 2023 10:42:54 +0100 (CET)
Date:   Tue, 14 Feb 2023 10:42:54 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: no answer after some
        iio_generic_buffer test cycles
Message-ID: <20230214094254.GA12246@frolo.macqel>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org> <Y+i9rImVqH7iVets@lore-desk> <20230213091957.GA4925@frolo.macqel> <20230213101654.GA5438@frolo.macqel> <Y+oWpKubqhgvCOVx@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+oWpKubqhgvCOVx@lore-desk>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lorenzo,

On Mon, Feb 13, 2023 at 11:53:24AM +0100, Lorenzo Bianconi wrote:
> 
> are you running level or edge interrupts? If you are using edge ones can you
> please check your kernel has the following fix?
> 
> commit 3f9bce7a22a3f8ac9d885c9d75bc45569f24ac8b
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Sat Nov 14 19:39:05 2020 +0100
> 
>     iio: imu: st_lsm6dsx: fix edge-trigger interrupts
> 
I had missed this one.  Adding it fixes the bug.

Thank you !

Philippe
