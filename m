Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0AA250F3
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2019 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEUNpq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 May 2019 09:45:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47526 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUNpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 May 2019 09:45:46 -0400
Received: from laptop-1.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DB0DE263B01;
        Tue, 21 May 2019 14:45:43 +0100 (BST)
Message-ID: <2741579da03893d2d4e7ad7f5fc42a506a82f380.camel@collabora.com>
Subject: Re: [alsa-devel] [PATCH v3 00/30] Update cros_ec_commands.h
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 15:45:41 +0200
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le jeudi 09 mai 2019 à 14:13 -0700, Gwendal Grignou a écrit :
> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
> 
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> That include file is converted to remove ACPI and Embedded only code.

Hi, 

I reviewed patches of the series and they looks good to me.

Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

