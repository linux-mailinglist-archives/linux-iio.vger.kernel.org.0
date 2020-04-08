Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00991A1C81
	for <lists+linux-iio@lfdr.de>; Wed,  8 Apr 2020 09:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgDHHWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Apr 2020 03:22:24 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:35004 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHHWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2020 03:22:24 -0400
Received: by mail-io1-f47.google.com with SMTP id w20so864189iob.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2020 00:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=U/vDou62n8EmCCxUOaZ8OkBOz8r22IdCgtFHZhQFqEM=;
        b=ocpp0enLJ6rudn/Od8MNeM0lUH3f7GqDCxGkHEdmHCjjp7rQGzdonXTKIPyfzYuQ7Z
         R4jEJ+bhpGI+blzWqhvVoY6lY6Q17+OC3rR5/1XWlDqovxU/r+TE5KgYOAPuQic+d+m3
         +st/KD3PedYggb5y0IsJsS2wjjiIZCeM05AzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=U/vDou62n8EmCCxUOaZ8OkBOz8r22IdCgtFHZhQFqEM=;
        b=m83diqmMEye1+eJ9m9WrNbjTwP6pKO8o3xh3edUIWTB6uYQv28Xsm0qc5WLwlAdNVC
         sR6dWoS3n2L0gq0OcrjpcNcFeXAQjj9wStHxpzlfk+7nCBfJWZ+orSYKd3NO9kt9wVy1
         uAH9/GUOOS1abDshNM6lQw1/Tuj8V811Q3jVzWK9k3kVo8Ha7Gg0UPP0EJK83wdf5jPJ
         33eFqcm91CeqG1rcfFGRf1RZ53d1JRf8DAGPiTBfHVoMGjRxVz21SWR9bVkpd+rn+TbS
         A70XIFP++RyLq/dJH3DtJea1uDrVN4lX6C7xDvOhlrEC8khRPc0u7O8dVn9ITrqNHmfw
         5lvQ==
X-Gm-Message-State: AGi0PuYXtlHoziOZRwocVUIyoxjKnn+4p93toWbqEjgdIZ+vVferUo6t
        k0eN79NxMG1tASxnw+WE6p307snUYyzJCpLDpQbgPiLTPeg=
X-Google-Smtp-Source: APiQypI+CBTizPP4yixnTGS10poNCivGLLkFpNc6Vhc9+5NxPLFCi9yFu/NzTM9qgu/GQ9gmop2d+XbX+mfb8FZNd50=
X-Received: by 2002:a02:1c07:: with SMTP id c7mr5516394jac.19.1586330543120;
 Wed, 08 Apr 2020 00:22:23 -0700 (PDT)
MIME-Version: 1.0
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 8 Apr 2020 00:22:10 -0700
Message-ID: <CAPUE2uuL8AU8ps=aLGgkqDR3FVxeWCOoMhj+OruZ6YT5Jn+m0Q@mail.gmail.com>
Subject: RFC: Present Screen rotation as counter
To:     vilhelm.gray@gmail.com, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Today, on chromebook, to detect screen orientation (portrait,
landscape, inverted portrait, inverted landscape), chrome is polling
lid accelerometer data and calculating the orientation.
To save power, I want the embedded controller (EC) to forward an event
when the lid acceleration detects an orientation change.
To convey that information, I would like to define a rotary encoder
with 4 regions, the counter increases when the screen is rotated
clockwise, (decreases when rotated counter-clockwise) and would
increment by 4 on a full rotation.
The EC knows the accelerometer placement relative to the screen, so we
can define landscape as count % 4 equals to 0.
Would such a counter fit into the counter subsystem?

Regards,
Gwendal.
