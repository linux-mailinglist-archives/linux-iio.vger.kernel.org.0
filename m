Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE75BD12A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiISPhx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISPhv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9028704
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 941B961031
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 15:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D59BC433C1;
        Mon, 19 Sep 2022 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663601870;
        bh=UFBMLa16OX4CwKyGK2zI+M/hqb9ZYMi7V0cC4h9/6RY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iuRQr9hC5o0FJaTVyekhfNSzTuRufi4PZtb3ewbTVArrbJgTHNtkv68BWetJOSUDr
         ul3geMn4Vk0J79BaWrU1G3EieSkQHLI5v8/nwTeC7HJbY5CH2cbpaLvys3S6WaErsJ
         jhOMqx9Tzxu1sS8E4GrwnMuyTxPK3QPG5B3sTKC199wXjncmtIE1djdoM6s+4ax6K7
         Q0dxmUG6tUAeXzWc7LU3EBcMHqrpTSf7Oiz4TS5cM89RR4OvCswN8Trtac/BpZazkN
         GYatqAkfxquN9N8rYNBs7f72ZPUE048xlHKPvhe1APpjbUBTeZaT4Z4DsrixCEpEJs
         5Xt9F6FDpGS6g==
Date:   Mon, 19 Sep 2022 16:37:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     bugzilla-daemon@kernel.org
Cc:     linux-iio@vger.kernel.org
Subject: Re: [Bug 200775] Cannot read the accelerometer raw data from the
 sensor LNG2DM
Message-ID: <20220919163755.49bec435@jic23-huawei>
In-Reply-To: <bug-200775-217253-w3BktBUZkz@https.bugzilla.kernel.org/>
References: <bug-200775-217253@https.bugzilla.kernel.org/>
        <bug-200775-217253-w3BktBUZkz@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Aug 2022 19:47:50 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=200775
> 
> --- Comment #7 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.com) ---
> Without OEM's help, we can't resolve. It is possible that Windows also polling.
> 

Annoying though it is to leave a user stuck.  I would suggest closing this one
given no means to obtain required info to debug.

Jonathan
