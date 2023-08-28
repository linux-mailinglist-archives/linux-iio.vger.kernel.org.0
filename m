Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C496A78B733
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjH1SXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 14:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjH1SXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 14:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F813D
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 11:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265C863F92
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 18:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA608C433C7;
        Mon, 28 Aug 2023 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693247010;
        bh=8GOWsAeShaCHQ0yHWRY7xBH7c6TZpUb/+DRCs9TmD7A=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=d1Xv5yMzK9zju6ZMR8qRJ2brGYnuk6+50IN5GM77uQSHOceW+KNxFYKycgCg4+vVj
         3CVKiSWpNGYFL/HAa+r2YWqj9HYEKmhGrV2xIRacXiym+36WfSk7HZbZ+q6LIuqvg5
         Or/OjqMW6EIPY7RFwHRYTMsUzM7Z7ymTgAkNhbokrDDGoqu4eO58Dy4VQtI3cJj+xk
         MkMEB5oC2n63+76lwI40H/bCmSn/egSl6SilaQ1EoiHheVKi4/jhIvR3wBjaafeYd2
         C9hYAJaT3JWaq3go84FQA/HFY+ZZrvx270IzIOy20GBuh6qk+5F2rjjE0ehJ6B0QGx
         jIbnk94g+rbDg==
Date:   Mon, 28 Aug 2023 19:23:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: IIO this cycle.
Message-ID: <20230828192350.66f2aec8@jic23-huawei>
In-Reply-To: <20230809182331.18c259c5@jic23-huawei>
References: <20230809182331.18c259c5@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Aug 2023 18:23:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Hi All,
> 
> I'm going to be travelling without a laptop next week so won't be sending
> my usual last minute second pull request to pick up the stuff that just
> squeaked over the line time wise.
> 
> As such I'm sorry to say the IIO tree is effectively closed for the 6.6
> merge window a week early as I won't be back online until after rc7.
> 
> I might queue up a few things over next few days but, with the exception
> of fixes, they will be targeting the 6.7 cycle.
> 
> Thanks,
> 
> Jonathan

Back in action (more or less :)  I think I caught up with what I'd consider
the 'normal' stuff mostly today.  There are a few series waiting for trees
to advance during the merge window (fixes for recent stuff mostly)

Otherwise it's the interesting series that are outstanding :)

iio: Add buffer write() support
Add converter framework
iio: Add iio backend device type

I'll try and take a first look at least in the next week.

Jonathan
