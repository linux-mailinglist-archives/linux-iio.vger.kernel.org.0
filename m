Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DD96362F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2019 14:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGIMsr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jul 2019 08:48:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:58182 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIMsq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Jul 2019 08:48:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2FDB1737;
        Tue,  9 Jul 2019 12:48:46 +0000 (UTC)
Date:   Tue, 9 Jul 2019 06:48:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: driver-api: generic-counter: fix file path to
 ABI doc
Message-ID: <20190709064845.6be66cd2@lwn.net>
In-Reply-To: <20190709110613.GA4476@icarus>
References: <20190709075436.7294-1-marcus.folkesson@gmail.com>
        <20190709110613.GA4476@icarus>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Jul 2019 20:06:33 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Fixes: 09e7d4ed8991 ("docs: Add Generic Counter interface documentation")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Jonathan, would you be able to pick this up in your tree?

I can apply it, yes.  But why are you supplying an SOB for it?

Thanks,

jon
